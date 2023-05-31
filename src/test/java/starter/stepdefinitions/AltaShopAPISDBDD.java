package starter.stepdefinitions;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.serenitybdd.screenplay.rest.interactions.Delete;
import net.serenitybdd.screenplay.rest.interactions.Get;
import net.serenitybdd.screenplay.rest.interactions.Post;
import net.serenitybdd.screenplay.rest.interactions.Put;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import starter.utilities.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.emptyString;

public class AltaShopAPISDBDD {
    String baseUrl = "https://altashop-api.fly.dev";
    User user = new User();

    @Given("{actor} call an api {string} with method {string} with payload below")
    public void callApi(Actor actor, String path, String method, DataTable table)  {
        actor.whoCan(CallAnApi.at(baseUrl));

        // Create request body json instance
        JSONObject bodyRequest = new JSONObject();

        // Get headers
        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        // Get values
        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        // Loop on every values Then set value with key from header to request body
        for (int i = 0; i < valueList.size(); i++) {
            String key = headerList.get(i);
            bodyRequest.put(key, valueList.get(key));
        }

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.body(bodyRequest)));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path).with(request -> request.body(bodyRequest)));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} call an api {string} with method {string}")
    public void callApi(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseUrl));
        JSONObject bodyRequest = new JSONObject();

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode);
    }

    @Then("{actor} verify {string} is exist")
    public void userVerifyIsExist(Actor actor, String data) {
        Response response = SerenityRest.lastResponse();
        response.then().body(data, not(emptyString()));
    }

    @Then("{actor} verify response body should contain {string}")
    public void userVerifyResponseBodyShouldContain(Actor actor, String text) {
        Response response = SerenityRest.lastResponse();
        response.then().body(containsString(text));
    }

    @Then("{actor} verify response is match with json schema {string}")
    public void userVerifyResponseIsMatchWithJsonSchema(Actor actor, String schema) {
        Response response = SerenityRest.lastResponse();
        response.then().body(matchesJsonSchemaInClasspath(schema));
    }

    @And("{actor} get token")
    public void userGetToken(Actor actor) {
        Response response = SerenityRest.lastResponse();
        user.setToken(response.path("data"));
    }

    @Given("{actor} call an api {string} with method {string} with payload below for auth")
    public void userCallAnApiWithMethodWithPayloadBelowForAuth(Actor actor, String path, String method, DataTable table) {
        actor.whoCan(CallAnApi.at(baseUrl));

        JSONArray jsonArrayWrapper = new JSONArray();

        // Create request body json instance
        JSONObject bodyRequest = new JSONObject();

        // Get headers
        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        // Get values
        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        // Loop on every values Then set value with key from header to request body
        for (int i = 0; i < valueList.size(); i++) {
            String key = headerList.get(i);
            bodyRequest.put(key, valueList.get(key));
        }

        jsonArrayWrapper.add(bodyRequest);

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(jsonArrayWrapper).log().all()));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path).with(request -> request.body(bodyRequest)));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }


    @Given("{actor} call an api {string} with method get to get info")
    public void userCallAnApiWithMethodToGetInfo(Actor actor, String path) {
        actor.whoCan(CallAnApi.at(baseUrl));
        JSONObject bodyRequest = new JSONObject();
        actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));
    }

    @Given("{actor} call an api {string} with method post to add new order")
    public void userCallAnApiWithMethodPostToAddNewOrder(Actor actor, String path) {
        actor.whoCan(CallAnApi.at(baseUrl));
        JSONObject bodyRequest = new JSONObject();
        JSONArray jsonArrayWrapper = new JSONArray();

        bodyRequest.put("product_id", 2);
        bodyRequest.put("quantity", 1);
        System.out.println(bodyRequest);
        System.out.println(jsonArrayWrapper);
        jsonArrayWrapper.add(bodyRequest);

        actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(jsonArrayWrapper).log().all()));

    }

    @Given("{actor} call an api {string} with method post to add new product")
    public void userCallAnApiWithMethodPostToAddNewProduct(Actor actor, String path) {
        actor.whoCan(CallAnApi.at(baseUrl));
        JSONObject bodyRequest = new JSONObject();

        List<Integer> listCategories = new ArrayList<>();
        listCategories.add(0,8822);
        listCategories.add(1,5938);
        listCategories.add(2,5939);

        bodyRequest.put("name", "Sony PS5");
        bodyRequest.put("description", "play has no limits");
        bodyRequest.put("price", 299);
        bodyRequest.put("categories", listCategories);
        System.out.println(bodyRequest);


        actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getToken()).body(bodyRequest).log().all()));

    }
}
