#* Check incoming request bodies
#* @filter Request body check
check_json_body <- function(req, res){

  is_post <- req$REQUEST_METHOD == "POST"
  is_job  <- req$PATH_INFO == '/api/v1/scraper/job'

  if(is_post && is_job){
    assert_json_content_type(req$CONTENT_TYPE)
    assert_json_body(req$postBody)
  }

  forward()
}
