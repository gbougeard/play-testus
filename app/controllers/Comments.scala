package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models.{TestStep, Comment}
import models.Comments._
import play.api.libs.json.Json


object Comments extends Controller {

  /**
   * This result directly redirect to the application home.
   */
//  val Home = Redirect(routes.Comments.list(0, 0))

  /**
   * Describe the comment form (used in both edit and create screens).
   */
//  val commentForm = Form(
//    mapping(
//      "id" -> optional(longNumber),
//      "name" -> nonEmptyText ,
//      "description" -> nonEmptyText
//    )
//      (Comment.apply)(Comment.unapply)
//  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
//  def index = Action {
//    Home
//  }

  //  def list = Action {
  //    val comments = models.Comments.findAll
  //    val html = views.html.comments("Liste des comments", comments)
  //    Ok(html)
  //  }

//  def list(page: Int, orderBy: Int) = Action {
//    implicit request =>
//      val comments = models.Comments.findPage(page, orderBy)
//      val html = views.html.comments.list("Liste des comments", comments, orderBy)
//      Ok(html)
//  }

  def view(id: Long) = Action {
    implicit request =>
      val comments = models.Comments.findByTestStep(id)
      println(comments.size + " comments")
      Ok(Json.toJson(comments))
  }

//  def edit(id: Long) = Action {
//    implicit request =>
//      models.Comments.findById(id).map {
//        comment => Ok(views.html.comments.edit("Edit Comment", id, commentForm.fill(comment)))
//      } getOrElse (NotFound)
//  }

  /**
   * Handle the 'edit form' submission
   *
   * @param id Id of the computer to edit
   */
//  def update(id: Long) = Action {
//    implicit request =>
//      commentForm.bindFromRequest.fold(
//        formWithErrors => BadRequest(views.html.comments.edit("Edit Comment - errors", id, formWithErrors)),
//        comment => {
//          models.Comments.update(comment)
//          //        Home.flashing("success" -> "Comment %s has been updated".format(comment.name))
//          Redirect(routes.Comments.list(0,1))
//        }
//      )
//  }

  /**
   * Display the 'new computer form'.
   */
//  def create = Action {
//    Ok(views.html.comments.create("New Comment", commentForm))
//  }

  /**
   * Handle the 'new computer form' submission.
   */
//  def save = Action {
//    implicit request =>
//      commentForm.bindFromRequest.fold(
//        formWithErrors => BadRequest(views.html.comments.create("New Comment - errors", formWithErrors)),
//        comment => {
//          models.Comments.insert(comment)
//          //        Home.flashing("success" -> "Comment %s has been created".format(comment.name))
//          Redirect(routes.Comments.list(0,1))
//        }
//      )
//  }

  /**
   * Handle computer deletion.
   */
//  def delete(id: Long) = Action {
//    models.Comments.delete(id)
//    Home.flashing("success" -> "Comment has been deleted")
//  }

  def save() = Action(parse.json) {
    implicit request =>
      println(request.body)
      val commentJson = request.body
      val comment = commentJson.as[Comment]
      try {
        models.Comments.insert(comment)
        Ok("Saved")
      }
      catch {
        case e:IllegalArgumentException =>
          BadRequest("testStep not found")
      }
  }

}