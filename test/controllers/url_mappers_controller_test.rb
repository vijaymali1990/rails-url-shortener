require 'test_helper'

class UrlMappersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_mapper = url_mappers(:one)
  end

  test "should get index" do
    get url_mappers_url
    assert_response :success
  end

  test "should get new" do
    get new_url_mapper_url
    assert_response :success
  end

  test "should create url_mapper" do
    assert_difference('UrlMapper.count') do
      post url_mappers_url, params: { url_mapper: {  } }
    end

    assert_redirected_to url_mapper_url(UrlMapper.last)
  end

  test "should show url_mapper" do
    get url_mapper_url(@url_mapper)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_mapper_url(@url_mapper)
    assert_response :success
  end

  test "should update url_mapper" do
    patch url_mapper_url(@url_mapper), params: { url_mapper: {  } }
    assert_redirected_to url_mapper_url(@url_mapper)
  end

  test "should destroy url_mapper" do
    assert_difference('UrlMapper.count', -1) do
      delete url_mapper_url(@url_mapper)
    end

    assert_redirected_to url_mappers_url
  end
end
