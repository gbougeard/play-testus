package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models.Story
import models.Stories._
import play.api.libs.json.Json


object Stories extends Controller {

  /**
   * This result directly redirect to the application home.
   */
  val Home = Redirect(routes.Stories.list(0, 0))

  /**
   * Describe the story form (used in both edit and create screens).
   */
  val storyForm = Form(
    mapping(
      "id" -> optional(longNumber),
      "description" -> nonEmptyText,
      "name" -> nonEmptyText
      //      "discontinued" -> optional(date("yyyy-MM-dd")),
      //      "company" -> optional(longNumber)
    )
      (Story.apply)(Story.unapply)
  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
  def index = Action {
    Home
  }

  //  def list = Action {
  //    val stories = models.Stories.findAll
  //    val html = views.html.stories("Liste des stories", stories)
  //    Ok(html)
  //  }

  def list(page: Int, orderBy: Int) = Action {
    implicit request =>
      val stories = models.Stories.findPage(page, orderBy)
      val html = views.html.stories.list("Liste des stories", stories, orderBy)
      Ok(html)
  }

  def view(id: Long) = Action {
    implicit request =>
      models.Stories.findById(id).map {
        story => Ok(views.html.stories.view("View Story", story))
      } getOrElse (NotFound)
  }

  def edit(id: Long) = Action {
    implicit request =>
      models.Stories.findById(id).map {
        story => Ok(views.html.stories.edit("Edit Story", id, storyForm.fill(story)))
      } getOrElse (NotFound)
  }

  /**
   * Handle the 'edit form' submission
   *
   * @param id Id of the computer to edit
   */
  def update(id: Long) = Action {
    implicit request =>
      storyForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.stories.edit("Edit Story - errors", id, formWithErrors)),
        story => {
          models.Stories.update(story)
          //        Home.flashing("success" -> "Story %s has been updated".format(story.name))
          Redirect(routes.Stories.list(0,1))
        }
      )
  }

  /**
   * Display the 'new computer form'.
   */
  def create = Action {
    Ok(views.html.stories.create("New Story", storyForm))
  }

  /**
   * Handle the 'new computer form' submission.
   */
  def save = Action {
    implicit request =>
      storyForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.stories.create("New Story - errors", formWithErrors)),
        story => {
          models.Stories.insert(story)
          //        Home.flashing("success" -> "Story %s has been created".format(story.name))
          Redirect(routes.Stories.list(0,1))
        }
      )
  }

  /**
   * Handle computer deletion.
   */
  def delete(id: Long) = Action {
    models.Stories.delete(id)
    Home.flashing("success" -> "Story has been deleted")
  }

  def findAll() = Action{
    Ok(Json.toJson(models.Stories.findAll))
  }

}