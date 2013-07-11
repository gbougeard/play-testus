import sbt._
import play.Project._
import sbt.Keys._

object Library {

  // Versions
  val akkaVersion                     = "2.2.0"
  val logbackVersion                  = "1.0.13"
  val slf4jVersion                    = "1.7.5"
  val mysqlVersion                    = "5.1.25"
  val jodaMapperVersion               = "0.3.0"
  val metricsVersion                  = "2.2.0"
  val secureSocialVersion             = "master-SNAPSHOT"
  val webjarsVersion                  = "2.1.0-2"
  val wjAngularVersion                = "1.1.5-1"
  val wjAngularUiVersion              = "0.4.0-1"
  val wjAngularUiBootstrapVersion     = "0.4.0"
  val wjAngularStrapVersion           = "0.7.4"
  val wjBootstrapVersion              = "2.3.2"
  val wjMomentJsVersion               = "2.0.0-1"
  val wjFontAwesomeVersion            = "3.2.1"
  val wjJQueryUiVersion               = "1.9.2"
  val wjFamFamFlagsVersion            = "0.0"

  // Libraries
  val akkaActor             = "com.typesafe.akka" %% "akka-actor" % akkaVersion
  val akkaSlf4j             = "com.typesafe.akka" %% "akka-slf4j" % akkaVersion
  val logbackClassic        = "ch.qos.logback" % "logback-classic" % logbackVersion
  val slf4j                 = "org.slf4j" % "slf4j-api" % slf4jVersion
  val mysql                 = "mysql" % "mysql-connector-java" % mysqlVersion
  val jodaMapper            = "com.github.tototoshi" %% "slick-joda-mapper" % jodaMapperVersion
  val metrics               = "nl.grons" % "metrics-scala_2.10" % metricsVersion
  val secureSocial          = "securesocial" %% "securesocial" % secureSocialVersion
  val webjars               = "org.webjars" % "webjars-play_2.10" % webjarsVersion
  val wjAngular             = "org.webjars" % "angularjs" % wjAngularVersion
  val wjAngularUi           = "org.webjars" % "angular-ui" % wjAngularUiVersion
  val wjAngularUiBootstrap  = "org.webjars" % "angular-ui-bootstrap" % wjAngularUiBootstrapVersion
  val wjAngularStrap        = "org.webjars" % "angular-strap" % wjAngularStrapVersion
  val wjBootstrap           = "org.webjars" % "bootstrap" % wjBootstrapVersion
  val wjMomentJs            = "org.webjars" % "momentjs" % wjMomentJsVersion
  val wjFontAwesome         = "org.webjars" % "font-awesome" % wjFontAwesomeVersion
  val wjJQueryUi            = "org.webjars" % "jquery-ui" % wjJQueryUiVersion
  val wjFamFamFlag          = "org.webjars" % "famfamfam-flags" % wjFamFamFlagsVersion

}

object ApplicationBuild extends Build {

  import Library._

  val appName = "testus"
  val appVersion = "1.0-SNAPSHOT"


  val appDependencies = Seq(
    // Add your project dependencies here,
    jdbc,
    slf4j,
    logbackClassic,
    mysql,
    jodaMapper,
    metrics,
    secureSocial,
    webjars,
    wjAngular,
    wjAngularStrap,
    wjAngularUi,
    wjAngularUiBootstrap,
    wjBootstrap,
    wjMomentJs,
    wjFontAwesome


//    , "com.yammer.metrics" % "metrics-scala_2.9.1" % "2.1.5"
//    , "com.yammer.metrics" % "metrics-graphite" % "2.1.5"

//    , "securesocial" %% "securesocial" % "master-SNAPSHOT"
//
//    , "org.webjars" % "webjars-play_2.10" % "2.1.0-1"
//    //    , "org.webjars" % "requirejs" % "2.1.1"
//    , "org.webjars" % "angularjs" % "1.1.3"
//    , "org.webjars" % "angular-strap" % "0.6.6"
//    , "org.webjars" % "angular-ui" % "0.3.2-1"
//    , "org.webjars" % "bootstrap" % "2.3.0"
//    , "org.webjars" % "font-awesome" % "3.0.0"
//    , "org.webjars" % "jquery-ui" % "1.9.2"
//    , "org.webjars" % "momentjs" % "1.7.2"
//    , "org.webjars" % "tinymce-jquery" % "3.4.9"
//    , "org.webjars" % "famfamfam-flags" % "0.0"

  )


  val main = play.Project(appName, appVersion, appDependencies).settings(
    resolvers += Resolver.url("sbt-plugin-snapshots", new URL("http://repo.scala-sbt.org/scalasbt/sbt-plugin-snapshots/"))(Resolver.ivyStylePatterns)
    // Add your own project settings here
    //  ).dependsOn(RootProject( uri("git://github.com/gbougeard/play-slick.git") ))
  ).dependsOn(RootProject(uri("git://github.com/freekh/play-slick.git")))

}
