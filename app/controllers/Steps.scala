package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models.Step
import play.api.libs.json.Json

import models.Steps._
import models.ScenarioSteps._
import play.api.Logger


object Steps extends Controller {

  /**
   * This result directly redirect to the application home.
   */
  val Home = Redirect(routes.Steps.list(0, 0))

  /**
   * Describe the step form (used in both edit and create screens).
   */
  val stepForm = Form(
    mapping(
      "id" -> optional(longNumber),
      "name" -> nonEmptyText ,
      "description" -> nonEmptyText
  //      "discontinued" -> optional(date("yyyy-MM-dd")),
      //      "company" -> optional(longNumber)
    )
      (Step.apply)(Step.unapply)
  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
  def index = Action {
    Home
  }

  //  def list = Action {
  //    val steps = models.Steps.findAll
  //    val html = views.html.steps("Liste des steps", steps)
  //    Ok(html)
  //  }

  def list(page: Int, orderBy: Int) = Action {
    implicit request =>
      val steps = models.Steps.findPage(page, orderBy)
      val html = views.html.steps.list("Liste des steps", steps, orderBy)
      Ok(html)
  }

  def view(id: Long) = Action {
    implicit request =>
      models.Steps.findById(id).map {
        step => Ok(views.html.steps.view("View Step", step))
      } getOrElse (NotFound)
  }

  def edit(id: Long) = Action {
    implicit request =>
      models.Steps.findById(id).map {
        step => Ok(views.html.steps.edit("Edit Step", id, stepForm.fill(step)))
      } getOrElse (NotFound)
  }

  /**
   * Handle the 'edit form' submission
   *
   * @param id Id of the computer to edit
   */
  def update(id: Long) = Action {
    implicit request =>
      stepForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.steps.edit("Edit Step - errors", id, formWithErrors)),
        step => {
          Logger.info("Update step "+step)
          models.Steps.update(id, step)
          Redirect(routes.Steps.edit(id)).flashing("success" -> "Step %s has been updated".format(step.name))
//          Redirect(routes.Steps.list(0,1))
        }
      )
  }

  /**
   * Display the 'new computer form'.
   */
  def create = Action {
    Ok(views.html.steps.create("New Step", stepForm))
  }

  /**
   * Handle the 'new computer form' submission.
   */
  def save = Action {
    implicit request =>
      stepForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.steps.create("New Step - errors", formWithErrors)),
        step => {
          models.Steps.insert(step)
          Redirect(routes.Steps.create()).flashing("success" -> "Step %s has been created".format(step.name))
//          Redirect(routes.Steps.list(0,1))
        }
      )
  }

  /**
   * Handle computer deletion.
   */
  def delete(id: Long) = Action {
    Logger.info("delete step "+id)
    models.Steps.delete(id)
    Redirect(routes.Steps.list(0,1))
//    Home.flashing("success" -> "Step has been deleted")
  }

  def jsonSrc(id: Long) = Action {
    implicit request =>
      val steps = models.ScenarioSteps.findNotInScenario(id)
      Ok(Json.toJson(steps))
  }

  def jsonTrg(id: Long) = Action {
    implicit request =>
      val steps = models.ScenarioSteps.findByIdScenario(id)
      Ok(Json.toJson(steps))
  }

 def json = Action {
    implicit request =>
      val steps = models.Steps.findAll
      Ok(Json.toJson(steps))
  }

}