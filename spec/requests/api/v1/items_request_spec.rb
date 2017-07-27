require 'rails_helper'

RSpec.describe "Items API", type: :request do
  it "index: returns a list of all items" do
    3.times do |n|
    Item.create(name: "Item_#{n}", description: "Description of item #{n}")
    end

    get '/api/v1/items'
    items_response = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(items_response.count).to eq(3)
    expect(items_response.first['name']).to eq('Item_0')
    expect(items_response.last['description']).to eq('Description of item 2')
  end

  it 'show: returns a single item by id' do
    item = Item.create(name: 'Flux Capacitor',
                       description: 'Time travel device running on Plutonium')
    id = item.id

    get "/api/v1/items/#{id}"
    item_response = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item_response['id']).to eq(id)
    expect(item_response['name']).to eq('Flux Capacitor')
  end

it 'create: creates a new item' do
  item_params = {name: 'Post Holder', description: 'It\'s for digging holes ... for posts' }

  post '/api/v1/items', params: item_params
  item = Item.last

  assert_response :success
  expect(response).to be_success
  expect(item.name).to eq(item_params[:name])
end


end