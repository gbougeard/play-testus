package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Scenario(id: Option[Long], name: String, description: Option[String], storyId: Long) {
}

// define tables
object Scenarios extends Table[Scenario]("scenario") {

  def id = column[Long]("id_scenario", O.PrimaryKey, O.AutoInc)

  def name = column[String]("name")

  def description = column[String]("description")

  def storyId = column[Long]("id_story")

  def * = id.? ~ name ~ description.? ~ storyId <>(Scenario, Scenario.unapply _)

  def autoInc = id.? ~ name ~ description.? ~ storyId <>(Scenario, Scenario.unapply _) returning id

  def steps = ScenarioSteps.filter(_.idStep === id).flatMap(_.step)

  // A reified foreign key relation that can be navigated to create a join
  def story = foreignKey("STORY_FK", storyId, Stories)(_.id)

  val byId = createFinderBy(_.id)
  val byName = createFinderBy(_.name)
  val byCode = createFinderBy(_.description)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Scenario] = {
    database.withSession {
      (for (c <- Scenarios.sortBy(_.name)) yield c).list
    }
  }

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
          .sortBy(scenario => orderField match {
          case 1 => scenario.description.asc
          case -1 => scenario.description.desc
          case 2 => scenario.name.asc
          case -2 => scenario.name.desc

        })
          .drop(offset)
          .take(pageSize)
             c <- t.story
        //               .sortBy(story => orderField match {
        //               case 3 => story.name.asc
        //               case -3 => story.name.desc
        //             })

        } yield (t, c)).list

      val totalRows = count
      Page(scenarios, page, offset, totalRows)
    }
  }

  def findById(id: Long): Option[Scenario] = database withSession {
    Scenarios.byId(id).firstOption
  }


  def findByName(name: String): Option[Scenario] = database withSession {
    Scenarios.byName(name).firstOption
  }

  def findByCode(description: String): Option[Scenario] = database withSession {
    Scenarios.byCode(description).firstOption
  }

  def insert(scenario: Scenario): Long = database withSession {
    Scenarios.autoInc.insert((scenario))
  }

  def update(scenario: Scenario) = database withSession {
    Scenarios.where(_.id === scenario.id).update(scenario)
  }

  def delete(scenarioId: Long) = database withSession {
    Scenarios.where(_.id === scenarioId).delete
  }


  /**
   * Construct the Map[String,String] needed to fill a select options set.
   */
  def options: Seq[(String, String)] = for {
    c <- findAll
  } yield (c.id.toString, c.name)

  // JSON
  implicit val scenarioFormat = Json.format[Scenario]

}