package starter.stepdefinitions;

import com.github.javafaker.Faker;
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
import org.json.simple.JSONObject;
import starter.utilities.User;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.emptyString;

public class StepDefinitions {
    String baseUrl = "178.128.210.192:8080";
    User user = new User();

    @Given("{actor} call an api {string} with method {string} with payload below")
    public void callApi(Actor actor, String path, String method, DataTable table)  {
        actor.whoCan(CallAnApi.at(baseUrl));

        JSONObject bodyRequest = new JSONObject();

        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        for (int i = 0; i < valueList.size(); i++) {
            Faker faker = new Faker(new Locale("in-ID"));

            String key = headerList.get(i);

            bodyRequest.put(key, valueList.get(key));

            switch (valueList.get(key)) {
                case "randomEmail" -> {
                    String randomEmail = faker.internet().emailAddress();
                    bodyRequest.put(key, randomEmail);
                    user.setEmail(randomEmail);
                }
                case "randomPassword" -> {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    user.setPassword(randomPassword);
                }
            }
        }

        switch (method) {
            case "GET" -> actor.attemptsTo(Get.resource(path));
            case "POST" -> actor.attemptsTo(Post.to(path).with(request -> request.body(bodyRequest).log().all()));
            case "PUT" -> actor.attemptsTo(Put.to(path).with(request -> request.body(bodyRequest)));
            case "DELETE" -> actor.attemptsTo(Delete.from(path));
            default -> throw new IllegalStateException("Unknown method");
        }
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode).log().all();
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
    @Given("{actor} call an API {string} with method {string} with payload below and specific token")
    public void userCallAnAPIWithMethodWithPayloadBelowAndSpecificToken(Actor actor, String path, String method, DataTable table) {
        actor.whoCan(CallAnApi.at(baseUrl));

        JSONObject bodyRequest = new JSONObject();

        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        for (int i = 0; i < valueList.size(); i++) {
            Faker faker = new Faker(new Locale("in-ID"));

            String key = headerList.get(i);

            switch (valueList.get(key)) {
                case "randomEmail" -> {
                    String randomEmail = faker.internet().emailAddress();
                    bodyRequest.put(key, randomEmail);
                    user.setEmail(randomEmail);
                }
                case "randomPassword" -> {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    user.setPassword(randomPassword);
                }
                case "randomFullname" -> bodyRequest.put(key, faker.name().fullName());
                case "randomProductName" -> bodyRequest.put(key, faker.commerce().productName());
                case "randomDescription" -> bodyRequest.put(key, faker.lorem().sentence());
                case "randomProductPrice" -> bodyRequest.put(key, Math.round(Float.parseFloat(faker.commerce().price())));
                case "randomProductId" -> bodyRequest.put(key, 14394);
                case "randomQuantity" -> bodyRequest.put(key, faker.number().randomDigitNotZero());
                case "randomRating" -> bodyRequest.put(key, faker.number().numberBetween(1, 5));
                case "userEmail" -> bodyRequest.put(key, user.getEmail());
                case "userPassword" -> bodyRequest.put(key, user.getPassword());
                default -> bodyRequest.put(key, valueList.get(key));
            }
        }
    }
}
