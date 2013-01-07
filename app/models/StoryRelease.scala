package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class StoryRelease(idStory: Long, idRelease: Long)

// define tables
object StoryReleases extends Table[StoryRelease]("story_release") {

  def idStory = column[Long]("id_story", O.PrimaryKey)

  def idRelease = column[Long]("id_release", O.PrimaryKey)

  def * = idStory ~ idRelease <>(StoryRelease, StoryRelease.unapply _)

  // A reified foreign key relation that can be navigated to create a join
  def release = foreignKey("RELEASE_FK", idRelease, Releases)(release => release.id)

  def story = foreignKey("STORY_FK", idStory, Stories)(_.id)

  val byRelease = createFinderBy(_.idRelease)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def count: Int = {
    database.withSession {
      (for {t <- Releases} yield t.id).list.size
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[(Release, Story)] = {

    val offset = pageSize * page

    database.withSession {
      val releases = (
        for {r <- Releases
          .sortBy(story => orderField match {
          case 1 => story.description.asc
          case -1 => story.description.desc
          case 2 => story.name.asc
          case -2 => story.name.desc
        })
          .drop(offset)
          .take(pageSize)
             s <- r.stories

        } yield (r, s)).list

      val totalRows = count
      Page(releases, page, offset, totalRows)
    }
  }

  def findByIdRelease(id: Long): Seq[(StoryRelease, Release, Story)] = {

    database.withSession {
      val storyReleases = (
        for {sr <- StoryReleases
             r <- sr.release
             if (r.id === id)
             s <- sr.story

        } yield (sr, r, s))

      storyReleases.list
    }

  }

  // JSON
  implicit val storyReleaseFormat = Json.format[StoryRelease]
}