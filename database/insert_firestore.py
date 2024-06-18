import json
from google.cloud import firestore
import sys

# LEIA ANTES DE EXECUTAR
# Passar como argumento o nome da coleção
# O arquivo json precisa ter o mesmo nome da coleção
# Consulte o README para mais informações

# Passar a coleção como parâmetro
c = sys.argv[1]

# Inicialização do Firestore
def initialize_firestore():
    # Substitua 'path/to/serviceAccountKey.json' pelo caminho para o arquivo de chave da conta de serviço
    db = firestore.Client.from_service_account_json('key.json')
    return db

# Função para importar dados do arquivo JSON
def import_data(db, json_file):
    with open(json_file, 'r') as file:
        data = json.load(file)

    collections = data[f'{c}']  # Obter o objeto 'ride' do JSON

    for key, data in collections.items():
        # Criar uma referência para o documento na coleção 'ride'
        doc_ref = db.collection(f'{c}').document(key)
        
        # Define os dados do documento
        doc_ref.set(data)  # 'data' é um dicionário Python com os dados de cada viagem

    print('Dados inseridos com sucesso!')

if __name__ == '__main__':
    db = initialize_firestore()
    # Substitua 'collections.json' pelo nome do seu arquivo JSON
    import_data(db, f'{c}.json')