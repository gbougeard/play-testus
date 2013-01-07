package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database


import play.api.libs.json._
import play.api.libs.functional.syntax._

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

//

case class Tag(id: Option[Long], name: String)


// define tables
object Tags extends Table[Tag]("tag") {
  def id = column[Long]("id_tag", O.PrimaryKey)

  def name = column[String]("lib_tag")

  def * = id.? ~ name <>(Tag, Tag.unapply _)
  def autoInc = id.? ~ name <>(Tag, Tag.unapply _)  returning id


  lazy val database = Database.forDataSource(DB.getDataSource())

  def findAll: Seq[Tag] = {
    database.withSession {
      (for (c <- Tags) yield c).list
    }
  }
}

