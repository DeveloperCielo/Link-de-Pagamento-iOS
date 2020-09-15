Pod::Spec.new do |s|
  s.name             = 'CieloPaymentLinkClient'
  s.version          = '1.0.1'
  s.summary          = 'SDK de integração com a API de link de pagamentos'

  s.description      = <<-DESC
Este SDK abstrai as chamadas de autenticação e criação do link de pagamento da Cielo.
                       DESC

  s.homepage         = 'https://github.com/DeveloperCielo/Link-de-Pagamento-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paulo Fernandes' => 'pfernandes@braspag.com.br' }
  s.source           = { :git => 'https://github.com/DeveloperCielo/Link-de-Pagamento-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source_files = 'CieloPaymentLink/CieloPaymentLink/**/*.{h,m,swift,framework}'
end
