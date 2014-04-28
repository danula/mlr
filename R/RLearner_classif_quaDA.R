#' @S3method makeRLearner classif.quaDA
makeRLearner.classif.quaDA = function() {
  makeRLearnerClassif(
    cl = "classif.quaDA",
    package = "DiscriMiner",
    par.set = makeParamSet(
      #makeNumericVectorLearnerParam(id="prior", lower=0, upper=1, default=NULL),
      ),
    twoclass = TRUE,
    multiclass = TRUE,
    numerics = TRUE,
    factors = FALSE,
    missings = FALSE,
    prob = TRUE
  )
}

#' @S3method trainLearner classif.quaDA
trainLearner.classif.quaDA = function(.learner, .task, .subset, .weights,  ...) {
  d = getTaskData(.task, .subset, target.extra=TRUE)
  is.prob = (.learner$predict.type == "prop")
  quaDA(variables = d$data, group = d$target, prob = is.prob)
}

#' @S3method predictLearner classif.quaDA
predictLearner.classif.quaDA = function(.learner, .model, .newdata, ...) {
  m = .model$learner.model
  p = classify(m, newdata = .newdata)
  #p$scores #we loose this information
  p$pred_class
}