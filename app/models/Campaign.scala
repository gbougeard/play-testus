package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database

import play.api.libs.json._
import play.api.libs.functional.syntax._


// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Campaign(id: Option[Long], name: String, description: Option[String], browser: String, lang: String, storyId: Long, releaseId: Option[Long])

// define tables
object Campaigns extends Table[Campaign]("campaign") {

  def id = column[Long]("id_campaign", O.PrimaryKey, O.AutoInc)

  def name = column[String]("name")

  def description = column[String]("description")

  def browser = column[String]("browser")

  def lang = column[String]("language")

  def storyId = column[Long]("id_story")

  def releaseId = column[Long]("id_release")

  def * = id.? ~ name ~ description.? ~ browser ~ lang ~ storyId ~ releaseId.? <>(Campaign, Campaign.unapply _)

  def autoInc = id.? ~ name ~ description.? ~ browser ~ lang ~ storyId ~ releaseId.? <>(Campaign, Campaign.unapply _) returning id

  // A reified foreign key relation that can be navigated to create a join
  def story = foreignKey("STORY_FK", storyId, Stories)(_.id)

  def release = foreignKey("RELEASE_FK", releaseId, Releases)(_.id)

  val byId = createFinderBy(_.id)
  val byName = createFinderBy(_.name)
  val byRelease = createFinderBy(_.releaseId)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Campaign] = {
    database.withSession {
      (for (c <- Campaigns.sortBy(_.name)) yield c).list
    }
  }

  def count: Int = {
    database.withSession {
      (for (c <- Campaigns) yield c.id).list.size
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[(Campaign, Map[String, Int])] = {
    val offset = pageSize * page

    database.withSession {
      val campaigns = (
        for {c <- Campaigns
          .sortBy(campaign => orderField match {
          case 1 => campaign.name.asc
          case -1 => campaign.name.desc
          case 2 => campaign.browser.asc
          case -2 => campaign.browser.desc
          case 3 => campaign.lang.asc
          case -3 => campaign.lang.desc
        })
          .drop(offset)
          .take(pageSize)

        } yield c).list

      val totalRows = count
      Page(campaigns.map(c => (c, campaignResults(c))), page, offset, totalRows)
    }
  }

  def campaignResults(campaign: Campaign): Map[String, Int] = {
    TestSteps.countByStatus(TestSteps.findByCampaign(campaign.id.getOrElse(0)))
  }

  def findById(id: Long): Option[Campaign] = database withSession {
    Campaigns.byId(id).firstOption
  }

  def findByName(name: String): Option[Campaign] = database withSession {
    Campaigns.byName(name).firstOption
  }

  def findByRelease(release: Long): Option[Campaign] = database withSession {
    Campaigns.byRelease(release).firstOption
  }

  def insert(campaign: Campaign): Long = database withSession {
    Campaigns.autoInc.insert((campaign))
  }

  def update(id: Long,campaign: Campaign) = database withSession {
    val campaign2update = campaign.copy(Some(id), campaign.name, campaign.description)
    Campaigns.where(_.id === id).update(campaign2update)
  }

  def delete(campaignId: Long) = database withSession {
    Campaigns.where(_.id === campaignId).delete
  }

  /**
   * Construct the Map[String,String] needed to fill a select options set.
   */
  def options: Seq[(String, String)] = for {c <- findAll} yield (c.id.toString, c.name)

  // JSON
  implicit val campaignFormat = Json.format[Campaign]
}

