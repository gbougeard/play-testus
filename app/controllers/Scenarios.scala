package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models._
import com.yammer.metrics.Metrics
import com.yammer.metrics.scala.Timer


object Scenarios extends Controller {

  val metric = Metrics.defaultRegistry().newTimer(classOf[Scenario], "Minute")
  val timer = new Timer(metric)

  /**
   * This result directly redirect to the application home.
   */
  val Home = Redirect(routes.Scenarios.list(0, 0))

  /**
   * Describe the scenario form (used in both edit and create screens).
   */
  val scenarioForm = Form(
    mapping(
      "id" -> optional(longNumber),
      "name" -> nonEmptyText,
      "description" -> optional(text),
      "storyId" -> longNumber
      //      "discontinued" -> optional(date("yyyy-MM-dd")),
      //      "company" -> optional(longNumber)
    )
      (Scenario.apply)(Scenario.unapply)
  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
  def index = Action {
    Home
  }

  //  def list = Action {
  //    val scenarios = models.Scenarios.findAll
  //    val html = views.html.scenarios("Liste des scenarios", scenarios)
  //    Ok(html)
  //  }

  def list(page: Int, orderBy: Int) = Action {
    implicit request =>
      val scenarios =  timer.time(models.Scenarios.findPage(page, orderBy))
      val html = views.html.scenarios.list("Liste des scenarios", scenarios, orderBy)
      Ok(html)
  }

  def view(id: Long) = Action {
    implicit request =>

      models.Scenarios.findById(id).map {
        scenario => {
          val steps =  timer.time(models.ScenarioSteps.findByIdScenario(id))
          val html =  views.html.scenarios.view("View Scenario", scenario, steps)
          Ok(html)
        }
      } getOrElse (NotFound)
  }

  def edit(id: Long) = Action {
    implicit request =>
      models.Scenarios.findById(id).map {
        scenario => {
          val steps =  timer.time(models.Steps.findAll)
          val html = views.html.scenarios.edit("Edit Scenario", id, scenarioForm.fill(scenario), models.Stories.options, steps)
          Ok(html)
        }
      } getOrElse (NotFound)
  }

  /**
   * Handle the 'edit form' submission
   *
   * @param id Id of the computer to edit
   */
  def update(id: Long) = TODO
  /*Action {
    implicit request =>
      scenarioForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.scenarios.edit("Edit Scenario - errors", id, formWithErrors, models.Players.options)),
        scenario => {
          models.Scenarios.update(scenario)
          //        Home.flashing("success" -> "Scenario %s has been updated".format(scenario.name))
          Redirect(routes.Scenarios.view(scenario.id))
        }
      )
  }*/

  /**
   * Display the 'new computer form'.
   */
  def create = TODO
  /*Action {
    Ok(views.html.scenarios.create("New Scenario", scenarioForm, models.Players.options))
  }*/

  /**
   * Handle the 'new computer form' submission.
   */
  def save = TODO
  /*Action {
    implicit request =>
      scenarioForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.scenarios.create("New Scenario - errors", formWithErrors, models.Players.options)),
        scenario => {
          models.Scenarios.insert(scenario)
          //        Home.flashing("success" -> "Scenario %s has been created".format(scenario.name))
          Redirect(routes.Scenarios.view(scenario.id))
        }
      )
  }*/

  /**
   * Handle computer deletion.
   */
  def delete(id: Long) = Action {
    models.Scenarios.delete(id)
    Home.flashing("success" -> "Scenario has been deleted")
  }

}