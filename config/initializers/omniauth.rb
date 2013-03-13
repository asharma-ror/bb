Rails.application.config.middleware.use OmniAuth::Builder do
  #All social provider Secret key and Api key goes here
    
  provider :facebook, '174963659310800', 'a89a4ee12004caeca3dbded466e7cf53' if Rails.env == "development"
  provider :facebook, '508264855890274', 'b0651f03f8dd5b1dffbd545e31deaca2' if Rails.env == "production"
  
  provider :google, 'staging-cat.herokuapp.com', 'q4oUPzUStej9HYPuE76b06jQ' if Rails.env == "production"
  provider :google, '553652486409.apps.googleusercontent.com', 'L18pLETzIMu5avzbNKNdOb9l' if Rails.env == "development"  
  
  provider :linkedin, 'xd22ajk8cprz', 'IoO8b3IFZW9xgB9V' if Rails.env == "production"
  provider :linkedin, 'celms6yloy9i', '8EVdO7cqsUuVyjMn' if Rails.env == "development"
    
end
