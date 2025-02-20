*** Settings ***
Library    RequestsLibrary

*** Test Cases ***
Verificar config de ambiente
    GET    https://dummyjson.com/docs/products

Trazer dados de busca por produto
    GET    url=https://dummyjson.com/products/categories