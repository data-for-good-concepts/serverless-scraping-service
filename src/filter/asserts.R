assert_json_content_type <- function(content_type){
  assert_that(
    content_type == 'application/json',
    msg = glue(.messages$invalid_json_content_type)
  )
}

assert_json_body <- function(body){
  assert_that(
    validate(body),
    msg = .messages$invalid_json_body
  )
}
