package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._
import play.api.Logger

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Step(id: Option[Long], name: String, description: String)

// define tables
object Steps extends Table[Step]("step") {

  def id = column[Long]("id_step", O.PrimaryKey, O.AutoInc)

  def name = column[String]("name")

  def description = column[String]("description")

  def * = id.? ~ name ~ description <>(Step, Step.unapply _)

  def autoInc = id.? ~ name ~ description <>(Step, Step.unapply _) returning id

  def scenarios = ScenarioSteps.filter(_.idScenario === id).flatMap(_.scenario)

  val byId = createFinderBy(_.id)
  val byName = createFinderBy(_.name)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Step] = {
    database.withSession {
      (for (c <- Steps.sortBy(_.name)) yield c).list
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[Step] = {

    val offset = pageSize * page
    database.withSession {
      val steps = (
        for {c <- Steps
          .sortBy(step => orderField match {
          case 1 => step.description.asc
          case -1 => step.description.desc
          case 2 => step.name.asc
          case -2 => step.name.desc
        })
          .drop(offset)
          .take(pageSize)
        } yield c).list

      val totalRows = (for (c <- Steps) yield c.id).list.size
      Page(steps, page, offset, totalRows)
    }
  }

  def findById(id: Long): Option[Step] = database withSession {
    Steps.byId(id).firstOption
  }

  def findByName(name: String): Option[Step] = database withSession {
    Steps.byName(name).firstOption
  }


  def insert(step: Step): Long = database withSession {
    Steps.autoInc.insert((step))
  }

  def update(id: Long, step: Step) = database withSession {
//    val step2update = step.copy(Some(id), step.name, step.description)
    val step2update = step.copy(Some(id))
    Steps.where(_.id === id).update(step2update)

  }

  def delete(stepId: Long) = database withSession {
    Steps.where(_.id === stepId).delete
  }


  /**
   * Construct the Map[String,String] needed to fill a select options set.
   */
  def options: Seq[(String, String)] = for {c <- findAll} yield (c.id.toString, c.name)


  //JSON
  implicit val stepFormat = Json.format[Step]
}

