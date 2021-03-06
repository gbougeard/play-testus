package controllers

import _root_.securesocial.core.Authorization
import _root_.securesocial.core.Identity
import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import views._

object Application extends Controller with securesocial.core.SecureSocial {

  def index = SecuredAction { implicit request =>
    Ok(views.html.index(request.user))
  }

  // a sample action using the new authorization hook
  def onlyTwitter = SecuredAction(WithProvider("twitter")) { implicit request =>
  //
  //    Note: If you had a User class and returned an instance of it from UserService, this
  //          is how you would convert Identity to your own class:
  //
  //    request.user match {
  //      case user: User => // do whatever you need with your user class
  //      case _ => // did not get a User instance, should not happen,log error/thow exception
  //    }
    Ok("You can see this because you logged in using Twitter")
  }
 // a sample action using the new authorization hook
  def onlyGithub = SecuredAction(WithProvider("github")) { implicit request =>
  //
  //    Note: If you had a User class and returned an instance of it from UserService, this
  //          is how you would convert Identity to your own class:
  //
  //    request.user match {
  //      case user: User => // do whatever you need with your user class
  //      case _ => // did not get a User instance, should not happen,log error/thow exception
  //    }
    Ok("You can see this because you logged in using Github")
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

// An Authorization implementation that only authorizes uses that logged in using twitter
case class WithProvider(provider: String) extends Authorization {
  def isAuthorized(user: Identity) = {
    user.id.providerId == provider
  }
}