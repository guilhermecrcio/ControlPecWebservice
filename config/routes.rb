Rails.application.routes.draw do
  
  #Cidades
  get "/cidades/uf/:uf" => "cidades#filtroPorUf"
  
  #Admin
  post "/clientes" => "clientes#novo"
  post "/usuarios" => "usuarios#novo"
  
  #Usuário
  post "/login/web" => "sessao#web"
  post "/login/mobile" => "sessao#mobile"
  
  get  "/empresas(/ativo/:ativo)" => "empresas#lista"
  get  "/empresas/:empresa" => "empresas#busca"
  post "/empresas" => "empresas#novo"
  put  "/empresas/:empresa" => "empresas#alterar"
  
  get  "/categorias(/ativo/:ativo)(/empresa/:empresa)" => "categorias#lista"
  get  "/categorias/:categoria" => "categorias#busca"
  post "/categorias" => "categorias#novo"
  put  "/categorias/:categoria" => "categorias#alterar"
  
  get  "/racas(/ativo/:ativo)(/empresa/:empresa)(/categoria/:categoria)" => "racas#lista"
  get  "/racas/:raca" => "racas#busca"
  post "/racas" => "racas#novo"
  put  "/racas/:raca" => "racas#alterar"
  
  get  "/lotes(/ativo/:ativo)(/empresa/:empresa)(/categoria/:categoria)(/raca/:raca)" => "lotes#lista"
  get  "/lotes/:lote" => "lotes#busca"
  post "/lotes" => "lotes#novo"
  put  "/lotes/:lote" => "lotes#alterar"
  
  get  "/cores_pelagem(/ativo/:ativo)(/empresa/:empresa)(/categoria/:categoria)(/raca/:raca)" => "cores_pelagem#lista"
  get  "/cores_pelagem/:cor_pelagem" => "cores_pelagem#busca"
  post "/cores_pelagem" => "cores_pelagem#novo"
  put  "/cores_pelagem/:cor_pelagem" => "cores_pelagem#alterar"
  
  get  "/motivos_morte(/ativo/:ativo)" => "motivos_morte#lista"
  get  "/motivos_morte/:motivo_morte" => "motivos_morte#busca"
  post "/motivos_morte" => "motivos_morte#novo"
  put  "/motivos_morte/:motivo_morte" => "motivos_morte#alterar"
  
  get  "/animais(/ativo/:ativo)(/empresa/:empresa)(/categoria/:categoria)(/cor_pelagem/:cor_pelagem)(/lote/:lote)(/motivo_morte/:motivo_morte)(/raca/:raca)(/gado_leiteiro/:gado_leiteiro)(/gado_morto/:gado_morto)(/reprodutor/:reprodutor)(/sexo/:sexo)(/data_morte_inicial/:data_morte_inicial/data_morte_final/:data_morte_final)(/data_nascimento_inicial/:data_nascimento_inicial/data_nascimento_final/:data_nascimento_final)(/data_venda_inicial/:data_venda_inicial/data_venda_final/:data_venda_final)/pagina/:pagina" => "animais#lista"
  get  "/animais/:animal" => "animais#busca"
  post "/animais" => "animais#novo"
  put  "/animais/:animal" => "animais#alterar"
  
end
