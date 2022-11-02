#* Feedback to check if service is online
#* @tag health
#* @get /status
#* @response 200 OK
function(req, res){
  res <- "Service is alive ❤️"

  log_info(res)

  return(res)
}
