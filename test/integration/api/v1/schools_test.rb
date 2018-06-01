require 'test_helper'

feature "Schools" do
  describe "#index" do

    it "return 401 when user is not authenticate " do

      get api_v1_schools_path

      assert_equal 401, last_response.status
    end

    it "return 401 when auth_token is unknown " do

      get api_v1_schools_path, nil , {'HTTP_AUTHORIZATION' => '1234AZER'}
      #get api_v1_schools_path, headers: {'HTTP_AUTHORIZATION' => '1234AZER'}

      assert_equal 401, last_response.status
    end

    it "return 200 when auth_token is unknown " do

      get api_v1_schools_path, nil , {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
    end

    it "return public school" do

      get api_v1_schools_path, {status: 'public'} , {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
      assert_equal 1 , json_response['schools'].length
      assert_equal "public school", json_response['schools'].first['name']
    end

    it "return private school" do

      get api_v1_schools_path, { status: 'private'} , {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
      assert_equal 1 , json_response['schools'].length
      assert_equal "private school", json_response['schools'].first['name']
    end
  end

  describe "#create" do

    it "return 201 when school is successfully created" do
      assert_difference "School.all.count" do
        post api_v1_schools_path, { school: {
          name: "new school",
          email: "email@domain.com"
          }} , {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 201, last_response.status
        assert_equal "new school", json_response['school']['name']
      end
    end

    it "doesn't create a new school when no name given" do
      assert_no_difference "School.all.count" do
        post api_v1_schools_path, { school: {
          name: ""
          }} , {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 422 , last_response.status
      end
    end
  end

    describe "#update" do

      it "return 200 when school is successfully updated" do

            put api_v1_school_path(2), { school: {
            name: "edit school",
            email: "email@domain.com"
            }} , {'HTTP_AUTHORIZATION' => 'valid_token'}

          assert_equal 200, last_response.status
          assert_equal "edit school", json_response['school']['name']

      end

      it "doesn't create a new school when no name given" do
          post api_v1_schools_path, { school: {
            name: ""
            }} , {'HTTP_AUTHORIZATION' => 'valid_token'}

          assert_equal 422 , last_response.status

      end

  end

  describe"#show" do
        it "returns a school by an id" do
          get api_v1_school_path(2), nil,
            {'HTTP_AUTHORIZATION' => 'valid_token'}
            assert_equal 200, last_response.status
            assert_equal "private school", json_response['school']['name']
      end
  end

  describe "#destroy" do
focus
    it "rerturn true when school is delete" do
      assert_difference "School.all.count", -1 do

        delete api_v1_school_path(1), nil ,{'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 200, last_response.status
      end
    end

  end

end
