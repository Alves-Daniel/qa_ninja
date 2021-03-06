describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "tom@gmail.com", password: "123456" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter único equipo" do
    before(:all) do
      # Dado que eu tenho um novo equipamento
      payload = {
        thumbnail: Helpers::get_thumb("sanfona.jpg"),
        name: "Sanfano",
        category: "Outros",
        price: 499,
      }

      MongoDB.new.remove_equipo(payload[:name], @user_id)

      # E tenho o id desse equipamento
      equipo = Equipos.new.create(payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # Quando faço um requisição get por id
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end
    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
