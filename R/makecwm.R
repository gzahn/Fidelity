#' Community-weighted means (CWM) taken from the `ecole` package
#'
#' Community-weighted means traits matrix (SU x traits)
#'
#' @param spp
#' array of species data, where rows=SUs, cols=species
#'
#' @param trait
#' array of traits data, where rows=species, cols=traits
#'
#' @param wa
#' logical, should weighted averaging step follow standardization
#'     step?  If TRUE, then use abundance weighted trait AVGS, if
#'     FALSE, then use abundance weighted trait TOTALS.
#'
#' @param stdz
#' standardize each trait by its 'minmax' (default), 'deviates', or
#'     'none'
#'
#' @param ...
#' further arguments passed to other methods
#'
#' @return
#' A community-weighted traits matrix (actually a data frame), where
#'    rows=SUs and cols=traits.
#'
#' @details
#' Behavior emulates PC-ORD; see also McCune and Grace (2002).
#' Recommend not changing default wa and stdz settings, as these
#' create the CWM matrix that is sensible for most other analyses.
#'
#' @examples
#' # following Fig. 2 in McCune (2015):
#' A <- data.frame(t(matrix(c(4,0,0,2,1,1,1,5,2,0,3,4),
#'                          nrow=3, ncol=4)))
#' dimnames(A)[[1]] <- paste0('Plot',1:4)
#' dimnames(A)[[2]] <- c('maple', 'oak', 'pine')
#' S <- data.frame(t(matrix(c(10,1,2,1,1,0),
#'                          nrow=2, ncol=3)))
#' dimnames(S)[[1]] <- c('maple', 'oak', 'pine')
#' dimnames(S)[[2]] <- c('shadetol', 'hardwood')
#' # trts standardized by none, abund-weighted totals
#' c1  <- makecwm(A, S, wa=FALSE, stdz='none')
#' # traits standardized by minmax, abund-weighted totals
#' c2  <- makecwm(A, S, wa=FALSE, stdz='minmax')
#' # traits standardized by std deviates, abund-weighted totals
#' c3  <- makecwm(A, S, wa=FALSE, stdz='deviates')
#' # traits standardized by none, abund-weighted averages
#' c4  <- makecwm(A, S, wa=TRUE, stdz='none')
#' # traits standardized by minmax, abund-weighted averages
#' c5  <- makecwm(A, S, wa=TRUE, stdz='minmax')       # PREFERRED!
#' # traits standardized by std deviates, abund-weighted averages
#' c6  <- makecwm(A, S, wa=TRUE, stdz='deviates')
#' # print values
#' list(c1,c2,c3,c4,c5,c6)
#'
#' @references
#' McCune, B., and J. B. Grace. 2002. Analysis of Ecological
#'     Communities. MjM Software, Gleneden Beach, Oregon, USA.
#'     304 pp.
#'
#' McCune, B. 2015. The front door to the fourth corner: variations on
#'     the sample unit x trait matrix in community ecology. Community
#'     Ecology 16:267-271.
#'
#' @export
#' @rdname makecwm
`makecwm` <- function(spp, trait, wa=TRUE,
                      stdz=c('minmax', 'deviates', 'none'), ...){
  spp   <- as.matrix(spp)
  trait <- as.matrix(trait)
  # standardizing traits
  stdz <- match.arg(stdz)
  if(stdz=='minmax'){     # by minmax of traits columns
    `standardize` <- function(x, ...){
      (x - min(x, ...)) / (max(x, ...) - min(x, ...))
    }
    trait <- apply(trait, MARGIN=2, FUN=standardize)
  }
  if(stdz=='deviates'){   # by standard deviates of traits cols
    `zscore` <- function(x, ...){
      (x - mean(x, ...)) /
        (sd(x, ...)*sqrt((length(x)-1)/(length(x))))
    }
    # trait <- apply(trait, MARGIN=2, FUN=scale) # uses n-1
    trait <- apply(trait, MARGIN=2, FUN=zscore)
  }
  # weighted averaging
  awt   <- spp %*% trait      # matrix multiplication
  if(wa) {
    out <- awt/rowSums(spp, ...)# abund weighted trait AVGS
  }else{
    out <- awt             # abund weighted trait TOTALS
  }
  out <- round(out, 3)
  out <- as.data.frame(out)
  return(out)
}
