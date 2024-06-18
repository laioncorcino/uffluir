import json
from google.cloud import firestore

# Inicialização do Firestore
def initialize_firestore():
    # Substitua 'path/to/serviceAccountKey.json' pelo caminho para o arquivo de chave da conta de serviço
    db = firestore.Client.from_service_account_json('key.json')
    return db

# Função para importar dados do arquivo JSON
def import_data(db, json_file):
    with open(json_file, 'r') as file:
        data = json.load(file)

    rides = data['ride']  # Obter o objeto 'ride' do JSON

    for ride_key, ride_data in rides.items():
        # Criar uma referência para o documento na coleção 'ride'
        doc_ref = db.collection('ride').document(ride_key)
        
        # Define os dados do documento
        doc_ref.set(ride_data)  # 'ride_data' é um dicionário Python com os dados de cada viagem

    print('Dados importados com sucesso!')

if __name__ == '__main__':
    db = initialize_firestore()
    # Substitua 'rides.json' pelo nome do seu arquivo JSON
    import_data(db, 'ride.json')