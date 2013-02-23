package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models.{TestStep, Campaign}
import models.TestSteps._
import play.api.libs.json.Json


object Campaigns extends Controller {

  /**
   * This result directly redirect to the application home.
   */
  val Home = Redirect(routes.Campaigns.list(0, 0))

  /**
   * Describe the campaign form (used in both edit and create screens).
   */
  val campaignForm = Form(
    mapping(
      "id" -> optional(longNumber),
      "name" -> nonEmptyText,
      "description" -> optional(text),
      "browser" -> text,
      "lang" -> text,
      "storyId" -> longNumber,
      "releaseId" -> optional(longNumber)
      //      "discontinued" -> optional(date("yyyy-MM-dd")),
      //      "company" -> optional(longNumber)
    )
      (Campaign.apply)(Campaign.unapply)
  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
  def index = Action {
    Home
  }

  //  def list = Action {
  //    val campaigns = models.Campaigns.findAll
  //    val html = views.html.campaigns("Liste des campaigns", campaigns)
  //    Ok(html)
  //  }

  def list(page: Int, orderBy: Int) = Action {
    implicit request =>
      val campaigns = models.Campaigns.findPage(page, orderBy)
      val html = views.html.campaigns.list("Liste des campaigns", campaigns, orderBy)
      Ok(html)
  }

  def run(id: Long) = Action {
    implicit request =>
      models.Campaigns.findById(id).map {
        campaign => {
          val scenarios = models.TestSteps.findScenariosByCampaign(id)
          val results = models.Campaigns.campaignResults(campaign)
          val html = views.html.campaigns.run("Run Campaign", campaign, results, scenarios)
          Ok(html)
        }
      } getOrElse (NotFound)
  }

  def view(id: Long) = Action {
    implicit request =>
      models.Campaigns.findById(id).map {
        campaign => {
          val scenarios = models.TestSteps.findScenariosByCampaign(id)
          val results = models.Campaigns.campaignResults(campaign)
          val html = views.html.campaigns.view("View Campaign", campaign, results, scenarios)
          Ok(html)
        }
      } getOrElse (NotFound)
  }

  def edit(id: Long) = Action {
    implicit request =>
      models.Campaigns.findById(id).map {
        campaign => Ok(views.html.campaigns.edit("Edit Campaign", id, campaignForm.fill(campaign)))
      } getOrElse (NotFound)
  }

  /**
   * Handle the 'edit form' submission
   *
   * @param id Id of the computer to edit
   */
  def update(id: Long) = Action {
    implicit request =>
      campaignForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.campaigns.edit("Edit Campaign - errors", id, formWithErrors)),
        campaign => {
          models.Campaigns.update(id, campaign)
          Redirect(routes.Campaigns.edit(id)).flashing("success" -> "Campaign %s has been updated".format(campaign.name))
          //          Redirect(routes.Campaigns.list(0,1))
        }
      )
  }

  /**
   * Display the 'new computer form'.
   */
  def create = Action {
    implicit request =>
      Ok(views.html.campaigns.create("New Campaign", campaignForm))
  }

  /**
   * Handle the 'new computer form' submission.
   */
  def save = Action {
    implicit request =>
      campaignForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.campaigns.create("New Campaign - errors", formWithErrors)),
        campaign => {
          models.Campaigns.insert(campaign)
          Redirect(routes.Campaigns.create()).flashing("success" -> "Campaign %s has been created".format(campaign.name))
          //          Redirect(routes.Campaigns.list(0,1))
        }
      )
  }

  /**
   * Handle computer deletion.
   */
  def delete(id: Long) = Action {
    implicit request =>
      models.Campaigns.delete(id)
      Home.flashing("success" -> "Campaign has been deleted")
  }

  def stepsByCampaignScenario(idC: Long, idS: Long) = Action {
    implicit request =>
      val steps = models.TestSteps.findByCampaignScenario(idC, idS)
      Ok(Json.toJson(steps))
  }

  def stepSucceed() = Action(parse.json) {
    implicit request =>
      println(request.body)
      val testStepJson = request.body
      val testStep = testStepJson.as[TestStep]
      try {
        models.TestSteps.update(testStep.id.getOrElse(0), testStep)
        Ok("Saved")
      }
      catch {
        case e: IllegalArgumentException =>
          BadRequest("testStep not found")
      }
  }

  def stepFailed() = Action(parse.json) {
    implicit request =>
//      println(request.body)
      val testStepJson = request.body
      val testStep = testStepJson.as[TestStep]
      try {
        models.TestSteps.update(testStep.id.getOrElse(0), testStep)
        Ok("Saved")
      }
      catch {
        case e: IllegalArgumentException =>
          BadRequest("testStep not found")
      }
  }

}