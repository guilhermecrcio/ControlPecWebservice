# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171011234433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animais", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.bigint "empresa_id", null: false
    t.bigint "categoria_id", null: false
    t.bigint "raca_id", null: false
    t.bigint "lote_id", null: false
    t.text "codigo", null: false
    t.text "descricao"
    t.date "data_nascimento", null: false
    t.date "data_morte"
    t.date "data_venda"
    t.bigint "cor_pelagem_id", null: false
    t.string "sexo", limit: 1, null: false
    t.text "anotacoes"
    t.boolean "gado_leiteiro", null: false
    t.boolean "gado_morto", default: false, null: false
    t.boolean "reprodutor", default: false, null: false
    t.bigint "motivo_morte_id"
    t.boolean "ativo", default: true, null: false
    t.boolean "perfil_publico", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_animais_on_ativo"
    t.index ["categoria_id"], name: "index_animais_on_categoria_id"
    t.index ["cliente_id"], name: "index_animais_on_cliente_id"
    t.index ["codigo"], name: "index_animais_on_codigo"
    t.index ["cor_pelagem_id"], name: "index_animais_on_cor_pelagem_id"
    t.index ["data_morte"], name: "index_animais_on_data_morte"
    t.index ["data_nascimento"], name: "index_animais_on_data_nascimento"
    t.index ["data_venda"], name: "index_animais_on_data_venda"
    t.index ["empresa_id"], name: "index_animais_on_empresa_id"
    t.index ["gado_leiteiro"], name: "index_animais_on_gado_leiteiro"
    t.index ["gado_morto"], name: "index_animais_on_gado_morto"
    t.index ["lote_id"], name: "index_animais_on_lote_id"
    t.index ["motivo_morte_id"], name: "index_animais_on_motivo_morte_id"
    t.index ["perfil_publico"], name: "index_animais_on_perfil_publico"
    t.index ["raca_id"], name: "index_animais_on_raca_id"
    t.index ["reprodutor"], name: "index_animais_on_reprodutor"
    t.index ["sexo"], name: "index_animais_on_sexo"
  end

  create_table "categorias", force: :cascade do |t|
    t.bigint "empresa_id", null: false
    t.text "descricao", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_categorias_on_ativo"
    t.index ["empresa_id"], name: "index_categorias_on_empresa_id"
  end

  create_table "cidades", force: :cascade do |t|
    t.text "nome", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.bigint "estado_id", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.integer "tipo", limit: 2, null: false
    t.text "nome"
    t.text "razao_social"
    t.text "nome_fantasia"
    t.string "cpf", limit: 11
    t.string "cnpj", limit: 14
    t.bigint "cidade_id", null: false
    t.text "endereco", null: false
    t.text "telefone", null: false
    t.text "email", null: false
    t.decimal "valor_acesso", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_clientes_on_ativo"
    t.index ["cidade_id"], name: "index_clientes_on_cidade_id"
  end

  create_table "cores_pelagem", force: :cascade do |t|
    t.bigint "empresa_id", null: false
    t.bigint "categoria_id", null: false
    t.bigint "raca_id", null: false
    t.text "descricao", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_cores_pelagem_on_ativo"
    t.index ["categoria_id"], name: "index_cores_pelagem_on_categoria_id"
    t.index ["empresa_id"], name: "index_cores_pelagem_on_empresa_id"
    t.index ["raca_id"], name: "index_cores_pelagem_on_raca_id"
  end

  create_table "empresas", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.integer "tipo", limit: 2, null: false
    t.text "nome"
    t.string "cpf", limit: 11
    t.text "razao_social"
    t.text "nome_fantasia"
    t.string "cnpj", limit: 14
    t.text "endereco", null: false
    t.bigint "cidade_id", null: false
    t.text "telefone", null: false
    t.text "email", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_empresas_on_ativo"
    t.index ["cidade_id"], name: "index_empresas_on_cidade_id"
    t.index ["cliente_id"], name: "index_empresas_on_cliente_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "uf", limit: 2, null: false
    t.text "nome", null: false
  end

  create_table "lotes", force: :cascade do |t|
    t.bigint "empresa_id", null: false
    t.bigint "categoria_id", null: false
    t.bigint "raca_id", null: false
    t.text "descricao", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_lotes_on_ativo"
    t.index ["categoria_id"], name: "index_lotes_on_categoria_id"
    t.index ["empresa_id"], name: "index_lotes_on_empresa_id"
    t.index ["raca_id"], name: "index_lotes_on_raca_id"
  end

  create_table "medidas_animal", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.decimal "altura", null: false
    t.decimal "comprimento_corporal", null: false
    t.decimal "circunferencia_escrotal", null: false
    t.decimal "comprimento_garupa", null: false
    t.decimal "largura_garupa", null: false
    t.decimal "perimetro_toracico", null: false
    t.decimal "profundidade_costela", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_medidas_animal_on_animal_id"
    t.index ["ativo"], name: "index_medidas_animal_on_ativo"
  end

  create_table "motivos_morte", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.text "descricao", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_motivos_morte_on_ativo"
    t.index ["cliente_id"], name: "index_motivos_morte_on_cliente_id"
  end

  create_table "ordenhas_animal", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.decimal "litros_leite", null: false
    t.text "anotacoes"
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_ordenhas_animal_on_animal_id"
    t.index ["ativo"], name: "index_ordenhas_animal_on_ativo"
  end

  create_table "pesos_animal", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.decimal "peso", null: false
    t.text "anotacoes"
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_pesos_animal_on_animal_id"
    t.index ["ativo"], name: "index_pesos_animal_on_ativo"
  end

  create_table "racas", force: :cascade do |t|
    t.bigint "empresa_id", null: false
    t.bigint "categoria_id", null: false
    t.text "descricao", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_racas_on_ativo"
    t.index ["categoria_id"], name: "index_racas_on_categoria_id"
    t.index ["empresa_id"], name: "index_racas_on_empresa_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.text "nome", null: false
    t.text "telefone", null: false
    t.text "email", null: false
    t.text "senha", null: false
    t.boolean "ativo", default: true, null: false
    t.text "token_web"
    t.text "token_mobile"
    t.datetime "token_expiracao_mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_usuarios_on_ativo"
    t.index ["cliente_id"], name: "index_usuarios_on_cliente_id"
    t.index ["email"], name: "index_usuarios_on_email"
    t.index ["senha"], name: "index_usuarios_on_senha"
    t.index ["token_expiracao_mobile"], name: "index_usuarios_on_token_expiracao_mobile"
    t.index ["token_mobile"], name: "index_usuarios_on_token_mobile"
    t.index ["token_web"], name: "index_usuarios_on_token_web"
  end

end
