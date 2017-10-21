
#' @title The moran_op() function computes the moran operator
#'
#' @param x_features a data.frame of features that will be coerced \code{\link[base]{as.matrix}}
#' @param coord_nb a data.frame of the nb-coordinate triplets (i,j,k) returned from \code{\link[datzen]{save_coord_nb}}
#'
#' @return A list of quantities related to the Moran Operator.
#' NOTE: the list structure is ready to be passed to the STAN mcmc software
#' @export
#'
#' @examples
#' library(spdep); example(columbus)
#' x_features = columbus$AREA
#' coord_nb = save_coord_nb(foo_spdf=columbus)
#' moran_op(x_features,coord_nb)

moran_op = function(x_features,
                    # ro_tpdb_files,
                    coord_nb
                    ){

    # adjacency matrix
    A <- matrix(rep(0,(length(unique(coord_nb[,1]))*length(unique(coord_nb[,1])))),
                nrow=length(unique(coord_nb[,1])),
                ncol=length(unique(coord_nb[,1]))
    )

    for (i in (1:nrow(coord_nb))){
      A[(coord_nb[i,1]),(coord_nb[i,2])] <- coord_nb[i,3]
    }


    # covariates

    # center and sd-scale
    X = scale(as.matrix(x_features))

    # only sd-scale
    # X = apply(as.matrix(x_features),MARGIN=2,FUN=function(x)x/sd(x))

    ##################################
    # Moran's Operator of X wrt A
    ##################################
    n_s <- nrow(X)  # number of spatial units
    I_mat <- diag(n_s)
    Ones_vec <- rep(1,n_s)

    P <- X %*% (solve((crossprod(X,X)),t(X)))
    P_orth <- I_mat-P


    mor_op_x_a <- (P_orth %*% A %*% P_orth)
    # mor_op_x_a = crossprod(X,X)


    ##################################
    # M is matrix of top q<<n eigenvectors of mor_op_x_a
    ##################################

    eig_mor_op <- eigen(mor_op_x_a)
    eig_val <- eig_mor_op$values
    eig_vec <- eig_mor_op$vectors

    # use all positive eigenvectors
    eig_val_pos <- eig_val[eig_val>0]
    eig_vec_pos <- eig_vec[,eig_val>0]


    ##################################
    # Define Q_s Precision Matrix of HH Sparse ICAR
    ##################################

    # M needed
    # all positive eigenvalues
    M <- eig_vec_pos
    # q = length(eig_val_pos)

    # dim(M)

    # Q_s needed
    DA1 <- diag(as.vector(A%*%Ones_vec),nrow=n_s,ncol=n_s)
    Q <- DA1 - A
    Q_s <- t(M) %*% Q %*% M


    # Note, Q_s is a much smaller matrix than n x n
    # eg, the random variable delta_s generated from p(delta_s) is q dim

    # stan code must be altered accordingly
    # input matrices as well as random effect dimension q


    #######################################
    # dumping data to stan
    # NOTE: don't have response yet
    # Z and E
    # append to list later
    #######################################

    # rstan format use ?stan()
    # list to feed into stan() call

    stan_dat_noresp <- list(
      N = n_s,
      p = (dim(X))[2],  # number of covariates
      q = (dim(Q_s))[2],  # number of kept eigenvalues
      # Z = Z,
      # E = E,
      X = X,  # scaled covariate matrix
      Q_s = Q_s,  # precision matrix
      M = M  # eigenbasis
    )

    return(stan_dat_noresp)

}


# using base [r] matrix alg

# TODO: use sparse matrix algebra
# TODO: use library(bigmemory)
# TODO: use sparse big matrix

