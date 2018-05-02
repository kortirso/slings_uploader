# Macros for testing omniauth controllers
module OmniauthMacros
  def vkontakte_hash
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
      'provider' => 'vkontakte',
      'uid' => '123545',
      'info' => {
        'email' => 'example_vkontakte@xyze.it',
        'name' => 'Alberto Pellizzon',
        'first_name' => 'Alberto',
        'last_name' => 'Pellizzon',
        'image' => ''
      },
      'extra' => {
        'raw_info' => {}
      },
      'credentials' => {
        'token' => '123',
        'expires_at' => 1_381_826_003,
        'expires' => true
      }
    )
  end

  def vkontakte_invalid_hash
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
      'provider' => 'vkontakte',
      'uid' => '123545',
      'info' => {
        'email' => '',
        'name' => 'Alberto Pellizzon',
        'first_name' => 'Alberto',
        'last_name' => 'Pellizzon',
        'image' => ''
      },
      'extra' => {
        'raw_info' => {}
      },
      'credentials' => {
        'token' => '123',
        'expires_at' => 1_381_826_003,
        'expires' => true
      }
    )
  end
end
