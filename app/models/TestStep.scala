package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._
import models.Steps._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class TestStep(id: Option[Long], numOrder: Int, status: String, stepId: Long, scenarioId: Long, campaignId: Long) {
}

// define tables
object TestSteps extends Table[TestStep]("test_step") {

  def id = column[Long]("id_test_step", O.PrimaryKey, O.AutoInc)

  def numOrder = column[Int]("num_order")

  def status = column[String]("status")

  def stepId = column[Long]("id_step")

  def scenarioId = column[Long]("id_scenario")

  def campaignId = column[Long]("id_campaign")

  def * = id.? ~ numOrder ~ status ~ stepId ~ scenarioId ~ campaignId <>(TestStep, TestStep.unapply _)

  def autoInc = id.? ~ numOrder ~ status ~ stepId ~ scenarioId ~ campaignId <>(TestStep, TestStep.unapply _) returning id

  def testSteps = Comments.where(_.testStepId === id)


  // A reified foreign key relation that can be navigated to create a join
  def step = foreignKey("STEP_FK", stepId, Steps)(_.id)

  def scenario = foreignKey("SCENARIO_FK", scenarioId, Scenarios)(_.id)

  def campaign = foreignKey("CAMPAIGN_FK", campaignId, Campaigns)(_.id)

  val byId = createFinderBy(_.id)
  val byCampaign = createFinderBy(_.campaignId)

  lazy val database = Database.forDataSource(DB.getDataSource())

  def findById(id: Long): Option[TestStep] = database withSession {
    TestSteps.byId(id).firstOption
  }

  def insert(testStep: TestStep): Long = database withSession {
    TestSteps.autoInc.insert((testStep))
  }

  def update(id:Long, testStep: TestStep) = database withSession {
    val testStep2update = testStep.copy(Some(id))
    TestSteps.where(_.id === id).update(testStep2update)
  }

  def delete(testStepId: Long) = database withSession {
    TestSteps.where(_.id === testStepId).delete
  }

  def findByCampaignScenario(idCampaign: Long, idScenario: Long): Seq[(TestStep, Step)] = {

    database.withSession {
      val testSteps = (
        for {ts <- TestSteps
          .where(_.scenarioId === idScenario)
          .where(_.campaignId === idCampaign)
          .sortBy(_.numOrder)
             s <- ts.step
        } yield (ts, s))

      testSteps.list
    }
  }

  def findByCampaign(idCampaign: Long): Seq[TestStep] = {

    database.withSession {
      val testSteps = (
        for {ts <- TestSteps
          .where(_.campaignId === idCampaign)
          .sortBy(_.numOrder)
        } yield ts)

      testSteps.list
    }
  }

  def countByStatus(list: Seq[TestStep]): Map[String, Int] = {
    list.groupBy(_.status).map(x => (x._1, 100*x._2.size/list.size))
  }

  def findScenariosByCampaign(id: Long): Seq[Scenario] = {

    database.withSession {
      val scenarios = (
        for {ts <- TestSteps
          .where(_.campaignId === id)
             s <- ts.scenario
        } yield s)



      scenarios.list.distinct
    }
  }

  //JSON

  implicit val testStepFormat = Json.format[TestStep]


  implicit val testStepWithStepReads: Reads[(TestStep, Step)] = (
    (__ \ 'testStep).read[TestStep] ~
      (__ \ 'step).read[Step]
    ) tupled

  // or using the operators inspired by Scala parser combinators for those who know them
  implicit val testStepWithStepWrites: Writes[(TestStep, Step)] = (
    (__ \ 'testStep).write[TestStep] ~
      (__ \ 'step).write[Step]
    ) tupled
  implicit val testStepWithStepFormat = Format(testStepWithStepReads, testStepWithStepWrites)


}