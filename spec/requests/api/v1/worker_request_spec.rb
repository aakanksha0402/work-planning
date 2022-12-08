require 'rails_helper'

RSpec.describe "Workers", type: :request do
  let!(:worker) { Worker.create(name: Faker::Name.unique.name) }

  describe "INDEX: GET /workers" do
    it "returns http success" do
      get "/api/v1/workers"
      response_body = JSON.parse(response.body).first
      expect(response_body['id']).to eq(worker.id)
      expect(response_body['name']).to eq(worker.name)
      expect(response.status).to eq(200)
    end
  end

  describe "CREATE: POST /workers" do
    it "returns http success" do
      post "/api/v1/workers", params: {worker: {name: "Random"}}
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to eq('Random')
      expect(response.status).to eq(200)
    end

    it "returns http error" do
      post "/api/v1/workers", params: {worker: {name: ""}}
      response_body = JSON.parse(response.body)
      expect(response_body['error']).to include('Name can\'t be blank')
      expect(response.status).to eq(400)
    end
  end

  describe "UPDATE: PUT /workers/:id" do
    it "returns http success" do
      put "/api/v1/workers/#{worker.id}", params: {worker: {name: "Some name change"}}
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to eq('Some name change')
      expect(response.status).to eq(200)
    end
  end

  describe "SHOW: GET /workers/:id" do
    it "returns http success" do
      get "/api/v1/workers/#{worker.id}"
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to eq(worker.name)
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE: DELETE /workers/:id" do
    it "returns http success" do
      delete "/api/v1/workers/#{worker.id}"
      response_body = JSON.parse(response.body)
      expect(response_body['message']).to eq('Worker deleted')
      expect(response.status).to eq(200)
    end
  end
end