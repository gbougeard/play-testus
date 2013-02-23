package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database


import play.api.libs.json._
import play.api.libs.functional.syntax._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Story(id: Option[Long], name: String, narrative: String)

// define tables
object Stories extends Table[Story]("story") {

  def id = column[Long]("id_story", O.PrimaryKey, O.AutoInc)

  def name = column[String]("name")

  def narrative = column[String]("narrative")

  def * = id.? ~ name ~ narrative <>(Story, Story.unapply _)

  def autoInc = id.? ~ name ~ narrative <>(Story, Story.unapply _) returning id

  val byId = createFinderBy(_.id)
  val byName = createFinderBy(_.name)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Story] = {
    database.withSession {
      (for (c <- Stories.sortBy(_.name)) yield c).list
    }
  }

  def count: Int = {
    database.withSession {
      (for (c <- Stories) yield c.id).list.size
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[Story] = {

    val offset = pageSize * page
    database.withSession {
      val storys = (
        for {c <- Stories
          .sortBy(story => orderField match {
          case 1 => story.narrative.asc
          case -1 => story.narrative.desc
          case 2 => story.name.asc
          case -2 => story.name.desc
        })
          .drop(offset)
          .take(pageSize)
        } yield c).list

      val totalRows = count
      Page(storys, page, offset, totalRows)
    }
  }

  def findById(id: Long): Option[Story] = database withSession {
    Stories.byId(id).firstOption
  }

  def findByName(name: String): Option[Story] = database withSession {
    Stories.byName(name).firstOption
  }


  def insert(story: Story): Long = database withSession {
    Stories.autoInc.insert((story))
  }

  def update(id:Long,story: Story) = database withSession {
    val story2update = story.copy(Some(id))
    Stories.where(_.id === id).update(story2update)
  }

  def delete(storyId: Long) = database withSession {
    Stories.where(_.id === storyId).delete
  }

  /**
   * Construct the Map[String,String] needed to fill a select options set.
   */
  def options: Seq[(String, String)] = for {c <- findAll} yield (c.id.toString, c.name)

  // JSON
  implicit val storyFormat = Json.format[Story]
}

