package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._

import models.Scenarios._
import models.Steps._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class ScenarioStep(idScenario: Long, idStep: Long, numOrder: Int)

// define tables
object ScenarioSteps extends Table[ScenarioStep]("scenario_step") {

  def idScenario = column[Long]("id_scenario", O.PrimaryKey)

  def idStep = column[Long]("id_step", O.PrimaryKey)

  def numOrder = column[Int]("num_order")

  def * = idScenario ~ idStep ~ numOrder <>(ScenarioStep, ScenarioStep.unapply _)

  // A reified foreign key relation that can be navigated to create a join
  def scenario = foreignKey("SCENARIO_FK", idScenario, Scenarios)(scenario => scenario.id)

  def step = foreignKey("STEP_FK", idStep, Steps)(_.id)

  val byScenario = createFinderBy(_.idScenario)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def count: Int = {
    database.withSession {
      (for {t <- Scenarios} yield t.id).list.size
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[(Scenario, Story)] = {

    val offset = pageSize * page

    database.withSession {
      val scenarios = (
        for {t <- Scenarios
          .sortBy(story => orderField match {
          case 1 => story.description.asc
          case -1 => story.description.desc
          case 2 => story.name.asc
          case -2 => story.name.desc
        })
          .drop(offset)
          .take(pageSize)
             c <- t.story

        } yield (t, c)).list

      val totalRows = count
      Page(scenarios, page, offset, totalRows)
    }
  }

  def findByIdScenario(id: Long): Seq[(ScenarioStep, Scenario, Step)] = {

    database.withSession {
      val scenarioSteps = (
        for {ss <- ScenarioSteps
          .sortBy(_.numOrder)
             sc <- ss.scenario
             if (sc.id === id)
             st <- ss.step

        } yield (ss, sc, st))

      scenarioSteps.list
    }
  }

  def findStepsInIdScenario(id: Long): Seq[Step] = {

    database.withSession {
      val scenarioSteps = (
        for {ss <- ScenarioSteps
          .sortBy(_.numOrder)
             sc <- ss.scenario
             if (sc.id === id)
             st <- ss.step

        } yield (st))

      scenarioSteps.list
    }
  }

  def findNotInScenario(id: Long): Seq[Step] = {
    val allSteps = Steps.findAll
    allSteps diff findStepsInIdScenario(id)
  }

  // JSON
  implicit val scenarioStepFormat = Json.format[ScenarioStep]

  implicit val reads: Reads[(ScenarioStep, Scenario, Step)] = (
    (__ \ 'scenarioStep).read[ScenarioStep] ~
      (__ \ 'scenario).read[Scenario] ~
      (__ \ 'step).read[Step]
    ) tupled

  // or using the operators inspired by Scala parser combinators for those who know them
  implicit val writes: Writes[(ScenarioStep, Scenario, Step)] = (
    (__ \ 'scenarioStep).write[ScenarioStep] ~
      (__ \ 'scenario).write[Scenario] ~
      (__ \ 'step).write[Step]
    ) tupled
  implicit val format = Format(reads, writes)
}