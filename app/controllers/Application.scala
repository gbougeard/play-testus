package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import views._

object Application extends Controller {


  def home = Action {
    //    val stories = Tags.findAll
    Ok(html.index("Your new application is ready."))
  }

  // -- Javascript routing
  def javascriptRoutes = Action {
    implicit request =>
      import routes.javascript._
      Ok(
        Routes.javascriptRouter("jsRoutes")(
          Comments.view,
          Comments.save,
          Campaigns.stepsByCampaignScenario,
          Campaigns.stepSucceed,
          Campaigns.stepFailed,
          Stories.findAll,
          Releases.genCampaigns,
          Releases.save
        )
      ).as("text/javascript")
  }

}