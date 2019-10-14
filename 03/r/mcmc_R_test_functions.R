# Test Functions for the MCMC lab in R


# test for pred() function

test_pred_correct_value <- function() {
    stopifnot(all(pred(c(1,0,0)) == x))
    stopifnot(all(pred(c(0,1,0)) == x^2))
    stopifnot(all(pred(c(0,0,1)) == x^3))
    
    # if they passed, say something nice
    praise()
}

# test for log_prob() function

test_log_prob <- function() {
    th <-c(1,1,1)
    
    # test that it returns only one value
    stopifnot(length(log_prob(th)) == 1)
    
    # test that it returns the right type of value
    stopifnot(is.double(log_prob(th)))
    
    # test an obvious case returns right result
    stopifnot(log_prob(c(100,100,100)) < log_prob(c(0,0,0)))
    
    # show em some love
    praise()
}

# test for metropolis-hastings update function

test_mh_update <- function() {
    # just make sure it runs and outputs the right types of stuff
    mh_update_output <- mh_update(c(0,0,0), 1E-3)
    th <- mh_update_output$th
    p <- mh_update_output$p
    a <- mh_update_output$a
    
    stopifnot(is.double(th))
    stopifnot(length(th) == 3)
    
    stopifnot(is.double(p))
    stopifnot(length(p) == 1)
    
    stopifnot(is.logical(a))
    stopifnot(length(a) == 1)
    
    praise()
}

# testing the mcmc run works

test_mh <- function() {
    # unit test- just make sure MH runs and gives right output types
    mh_output <- mh(1)
    th <- mh_output$th
    p <- mh_output$p
    a <- mh_output$a
    #c(th, l, a) %<-% mh(1)
    
    stopifnot(is.double(th))
    stopifnot(length(th) == 3)
    
    stopifnot(is.double(p))
    stopifnot(length(p) == 1)
    
    stopifnot(is.double(a))
    stopifnot(length(a) == 1)
    
    # congrats
    praise()
}