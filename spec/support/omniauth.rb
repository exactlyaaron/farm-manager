# def set_omniauth(opts = {})
#   default = {:provider => :facebook,
#              :uuid     => "1234",
#              :facebook => {
#                             :email => "foobar@example.com",
#                             :gender => "Male",
#                             :name => "Foo Bar"
#                           }
#             }

#   credentials = default.merge(opts)
#   provider = credentials[:provider]
#   user_hash = credentials[provider]

#   OmniAuth.config.test_mode = true

#   OmniAuth.config.mock_auth[provider] = {
#     'uid' => credentials[:uuid],
#     "extra" => {
#     "user_hash" => {
#       "email" => user_hash[:email],
#       "name" => user_hash[:name]
#       }
#     }
#   }
# end

# def set_invalid_omniauth(opts = {})

#   credentials = { :provider => :facebook,
#                   :invalid  => :invalid_crendentials
#                  }.merge(opts)

#   OmniAuth.config.test_mode = true
#   OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

# end