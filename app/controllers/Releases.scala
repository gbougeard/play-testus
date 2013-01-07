package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import models._
import models.Campaigns._
import models.Releases._
import com.yammer.metrics.Metrics
import com.yammer.metrics.scala.Timer
import play.api.libs.json.Json


object Releases extends Controller {

  val metric = Metrics.defaultRegistry().newTimer(classOf[Release], "Minute")
  val timer = new Timer(metric)

  /**
   * This result directly redirect to the application home.
   */
  val Home = Redirect(routes.Releases.list(0, 0))

  /**
   * Describe the release form (used in both edit and create screens).
   */
  val releaseForm = Form(
    mapping(
      "id" -> optional(longNumber),
      "name" -> nonEmptyText,
      "description" -> optional(text)
      //      "company" -> optional(longNumber)
    )
      (Release.apply)(Release.unapply)
  )

  // -- Actions
  /**
   * Handle default path requests, redirect to computers list
   */
  def index = Action {
    Home
  }

  //  def list = Action {
  //    val releases = models.Releases.findAll
  //    val html = views.html.releases("Liste des releases", releases)
  //    Ok(html)
  //  }

  def list(page: Int, orderBy: Int) = Action {
    implicit request =>
      val releases = timer.time(models.Releases.findPage(page, orderBy))
      val html = views.html.releases.list("Liste des releases", releases, orderBy)
      Ok(html)
  }

  def view(id: Long) = Action {
    implicit request =>

      models.Releases.findById(id).map {
        release => {
          //val steps =  timer.time(models.ReleaseSteps.findByIdRelease(id))
          val html = views.html.releases.view("View Release", release)
          Ok(html)
        }
      } getOrElse (NotFound)
  }

  def edit(id: Long) = Action {
    implicit request =>
      models.Releases.findById(id).map {
        release => {
          val steps = timer.time(models.Steps.findAll)
          val html = views.html.releases.edit("Edit Release", id, releaseForm.fill(release), models.Stories.options, steps)
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
      releaseForm.bindFromRequest.fold(
        formWithErrors => BadRequest(views.html.releases.edit("Edit Release - errors", id, formWithErrors, models.Players.options)),
        release => {
          models.Releases.update(release)
          //        Home.flashing("success" -> "Release %s has been updated".format(release.name))
          Redirect(routes.Releases.view(release.id))
        }
      )
  }*/

  /**
   * Display the 'new computer form'.
   */
  def create = Action {
    Ok(views.html.releases.create("New Release", releaseForm, models.Stories.options))
  }

  /**
   * Handle the 'new computer form' submission.
   */
  def save = Action(parse.json) {
    implicit request =>
      val json = request.body
      println(json)
      val release = json.as[Release]
      val id = models.Releases.insert(release)
      Ok(Json.toJson(id))
    //        Home.flashing("success" -> "Release %s has been created".format(release.name))
  }

  /**
   * Handle computer deletion.
   */
  def delete(id: Long) = Action {
    models.Releases.delete(id)
    Home.flashing("success" -> "Release has been deleted")
  }

  def genCampaigns() = Action(parse.json) {
    implicit request =>
      val json = request.body
      println(json);
      val campaigns = json.as[Seq[Campaign]]
      campaigns.map(models.Campaigns.insert)
      Ok //(Json.toJson(campaigns))

  }

}