# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
roles = Role.create([
    { name: "Diretoria"},
    { name: "Tecnolodia da Informação"},
    { name: "Recursos Humanos"},
    { name: "Departamento Pessoal"},
    { name: "Contabilidade"},
    { name: "Fiscal"},
    { name: "Marketing"},
    { name: "Ecommerce"},
    { name: "Compras"},
    { name: "Financeiro"},
    { name: "Logistica"}
])

User.create!({:email => "admin@admin.com", :password => "123456", :password_confirmation => "123456", :username => "admin" })