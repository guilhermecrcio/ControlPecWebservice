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

ActiveRecord::Schema.define(version: 20171003235047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cidades", force: :cascade do |t|
    t.text "nome", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.bigint "estados_id", null: false
    t.index ["estados_id"], name: "index_cidades_on_estados_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.integer "tipo", limit: 2, null: false
    t.text "nome"
    t.text "razao_social"
    t.text "nome_fantasia"
    t.string "cpf", limit: 11
    t.string "cnpj", limit: 14
    t.bigint "cidades_id", null: false
    t.text "endereco", null: false
    t.text "telefone", null: false
    t.text "email", null: false
    t.decimal "valor_acesso", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ativo"], name: "index_clientes_on_ativo"
    t.index ["cidades_id"], name: "index_clientes_on_cidades_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "uf", limit: 2, null: false
    t.text "nome", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.bigint "clientes_id", null: false
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
    t.index ["clientes_id"], name: "index_usuarios_on_clientes_id"
    t.index ["email"], name: "index_usuarios_on_email"
    t.index ["senha"], name: "index_usuarios_on_senha"
    t.index ["token_expiracao_mobile"], name: "index_usuarios_on_token_expiracao_mobile"
    t.index ["token_mobile"], name: "index_usuarios_on_token_mobile"
    t.index ["token_web"], name: "index_usuarios_on_token_web"
  end

end
