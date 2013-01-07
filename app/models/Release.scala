package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database
import play.api.libs.json._
import play.api.libs.functional.syntax._
import java.sql.Timestamp
import org.joda.time.DateTime

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Release(id: Option[Long], name: String, description: Option[String])

// define tables
object Releases extends Table[Release]("releases") {

  def id = column[Long]("id_release", O.PrimaryKey, O.AutoInc)

  def name = column[String]("name")

  def description = column[String]("description")

  def * = id.? ~ name ~ description.? <>(Release, Release.unapply _)

  def autoInc = id.? ~ name ~ description.? <>(Release, Release.unapply _) returning id

  def stories = StoryReleases.filter(_.idRelease === id).flatMap(_.story)

  val byId = createFinderBy(_.id)
  val byName = createFinderBy(_.name)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Release] = {
    database.withSession {
      (for (c <- Releases.sortBy(_.name)) yield c).list
    }
  }

  def count: Int = {
    database.withSession {
      (for (c <- Releases) yield c.id).list.size
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[Release] = {

    val offset = pageSize * page
    database.withSession {
      val releases = (
        for {c <- Releases
          .sortBy(release => orderField match {
          case 1 => release.name.asc
          case -1 => release.name.desc
        })
          .drop(offset)
          .take(pageSize)
        } yield c).list

      val totalRows = count
      Page(releases, page, offset, totalRows)
    }
  }

  def findById(id: Long): Option[Release] = database withSession {
    Releases.byId(id).firstOption
  }

  def insert(release: Release): Long = database withSession {
    //val c = Release(None, release.name, release.description, new DateTime())
    Releases.autoInc.insert(release)
  }

  def update(release: Release) = database withSession {
    Releases.where(_.id === release.id).update(release)
  }

  def delete(releaseId: Long) = database withSession {
    Releases.where(_.id === releaseId).delete
  }


  //JSON
  implicit val releaseFormat = Json.format[Release]

}

