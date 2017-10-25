Rails.application.routes.draw do
  
  #Cidades
  get "/cidades/uf/:uf" => "cidades#filtroPorUf"
  
  #Admin
  post "/clientes" => "clientes#novo"
  post "/usuarios" => "usuarios#novo"
  
  #Usuário
  post "/login/web"    => "sessao#web"
  post "/login/mobile" => "sessao#mobile"
  
  get  "/empresas"          => "empresas#lista"
  get  "/empresas/:empresa" => "empresas#busca"
  post "/empresas"          => "empresas#novo"
  put  "/empresas/:empresa" => "empresas#alterar"
  
  get  "/categorias"            => "categorias#lista"
  get  "/categorias/:categoria" => "categorias#busca"
  post "/categorias"            => "categorias#novo"
  put  "/categorias/:categoria" => "categorias#alterar"
  
end
