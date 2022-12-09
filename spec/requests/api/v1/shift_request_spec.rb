require 'rails_helper'

RSpec.describe "Shifts", type: :request do
  let(:worker) { Worker.create(name: Faker::Name.unique.name) }
  let!(:shift) { Shift.create(shift_name: '0-8', work_date: '22/12/2022', worker: worker) }

  describe "INDEX: GET /shifts" do
    it "returns http success" do
      get "/api/v1/shifts"
      response_body = JSON.parse(response.body).first
      expect(response_body['id']).to eq(shift.id)
      expect(response_body['shift_name']).to eq(shift.shift_name)
      expect(response_body['worker']).not_to be nil
      expect(response.status).to eq(200)
    end
  end

  describe "CREATE: POST /shifts" do
    it "returns http success" do
      post "/api/v1/shifts", params: {shift: {shift_name: "0-8", work_date: "23/12/2022", worker_id: worker.id}}
      response_body = JSON.parse(response.body)
      expect(response_body['shift_name']).to eq('0-8')
      expect(response_body['worker']).not_to be nil
      expect(response.status).to eq(200)
    end

    context 'when worker does not exist' do
      it 'returns http error' do
        post "/api/v1/shifts", params: {shift: {shift_name: "0-8", work_date: "23/12/2022"}}
        response_body = JSON.parse(response.body)
        expect(response_body['error']).to include('Worker must exist')
        expect(response.status).to eq(422)
      end
    end

    context 'when a shift is already present' do
      it "returns http error" do
        post "/api/v1/shifts", params: {shift: {shift_name: "8-16", work_date: "22/12/2022", worker_id: worker.id}}
        response_body = JSON.parse(response.body)
        expect(response_body['error']).to include('Double shift in a day is not allowed')
        expect(response.status).to eq(422)
      end
    end

    context 'when shift_name or work_date is not present' do
      it "returns http error" do
        post "/api/v1/shifts", params: {shift: {worker_id: worker.id}}
        response_body = JSON.parse(response.body)
        expect(response_body['error']).to include("Please enter date in YYYY/MM/DD format")
        expect(response_body['error']).to include("Shift name can't be blank")
        expect(response.status).to eq(422)
      end
    end
  end

  describe "UPDATE: PUT /shifts/:id" do
    it "returns http success" do
      put "/api/v1/shifts/#{shift.id}", params: {shift: {shift_name: "8-16"}}
      response_body = JSON.parse(response.body)
      expect(response_body['shift_name']).to eq('8-16')
      expect(response.status).to eq(200)
    end
  end

  describe "SHOW: GET /shifts/:id" do
    it "returns http success" do
      get "/api/v1/shifts/#{shift.id}"
      response_body = JSON.parse(response.body)
      expect(response_body['shift_name']).to eq(shift.shift_name)
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE: DELETE /shifts/:id" do
    it "returns http success" do
      delete "/api/v1/shifts/#{shift.id}"
      response_body = JSON.parse(response.body)
      expect(response_body['message']).to eq('Shift deleted')
      expect(response.status).to eq(200)
    end
  end
end