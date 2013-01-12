package models

import play.api.db.DB

import play.api.Play.current

import scala.slick.driver.MySQLDriver.simple._
import scala.slick.session.Database
import play.api.libs.json._
import play.api.libs.json.util._
import play.api.libs.json.Writes._
import play.api.libs.json.Reads._
import play.api.libs.functional.syntax._
import java.sql.Timestamp
import org.joda.time.DateTime

// Use the implicit threadLocalSession

import scala.slick.session.Database.threadLocalSession

case class Comment(id: Option[Long], author: String, texte: String, testStepId: Long, dtCreat: DateTime)

// define tables
object Comments extends Table[Comment]("comment") {

  def id = column[Long]("id_comment", O.PrimaryKey, O.AutoInc)

  def author = column[String]("creat_by")

  def texte = column[String]("texte")

  def testStepId = column[Long]("id_test_step")

  def dtCreat = column[DateTime]("dt_creat")

  implicit val dateTime: TypeMapper[DateTime]
  = MappedTypeMapper.base[DateTime, Timestamp](dt => new
      Timestamp(dt.getMillis), ts => new DateTime(ts.getTime))


  def * = id.? ~ author ~ texte ~ testStepId ~ dtCreat <>(Comment, Comment.unapply _)

  def autoInc = id.? ~ author ~ texte ~ testStepId ~ dtCreat <>(Comment, Comment.unapply _) returning id

  // A reified foreign key relation that can be navigated to create a join
  def testStep = foreignKey("TEST_STEP_FK", testStepId, TestSteps)(_.id)

  val byId = createFinderBy(_.id)
  val byAuthor = createFinderBy(_.author)
  val byTestStep = createFinderBy(_.testStepId)

  lazy val database = Database.forDataSource(DB.getDataSource())

  lazy val pageSize = 10

  def findAll: Seq[Comment] = {
    database.withSession {
      (for (c <- Comments.sortBy(_.author)) yield c).list
    }
  }

  def findPage(page: Int = 0, orderField: Int): Page[Comment] = {

    val offset = pageSize * page
    database.withSession {
      val comments = (
        for {c <- Comments
          .sortBy(comment => orderField match {
          case 1 => comment.texte.asc
          case -1 => comment.texte.desc
          case 2 => comment.author.asc
          case -2 => comment.author.desc
        })
          .drop(offset)
          .take(pageSize)
        } yield c).list

      val totalRows = (for (c <- Comments) yield c.id).list.size
      Page(comments, page, offset, totalRows)
    }
  }

  def findById(id: Long): Option[Comment] = database withSession {
    Comments.byId(id).firstOption
  }

  def findByAuthor(author: String): Option[Comment] = database withSession {
    Comments.byAuthor(author).firstOption
  }

  def findByTestStep(id: Long): Seq[Comment] = database withSession {
    Comments.byTestStep(id).list
  }


  def insert(comment: Comment): Long = database withSession {
    val c = Comment(None, comment.author, comment.texte, comment.testStepId, new DateTime())
    Comments.autoInc.insert(c)
  }

  def update(comment: Comment) = database withSession {
    Comments.where(_.id === comment.id).update(comment)
  }

  def delete(commentId: Long) = database withSession {
    Comments.where(_.id === commentId).delete
  }

  //JSON
  implicit val commentReads: Reads[Comment] = (
    (__ \ "id").readNullable[Long] ~
      (__ \ "author").read[String] ~
      (__ \ "texte").read[String] ~
      (__ \ "testStepId").read[Long] ~
      (__ \ "dtCreat").read[DateTime].orElse(Reads.pure(new DateTime()))
    )(Comment)

  // or using the operators inspired by Scala parser combinators for those who know them
  implicit val commentWrites: Writes[Comment] = (
    (__ \ "id").write[Option[Long]] ~
      (__ \ "author").write[String] ~
      (__ \ "texte").write[String] ~
      (__ \ "testStepId").write[Long] ~
      (__ \ "dtCreat").write[DateTime]
    )(unlift(Comment.unapply))

  implicit val commentFormat = Format(commentReads, commentWrites)

}

