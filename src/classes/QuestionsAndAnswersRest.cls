@RestResource(urlMapping='/Question/*')
global with sharing class QuestionsAndAnswersRest {

    @HttpGet
    global static String getAllQuestionsAndAnswers(){

        List<Question__c> questions = [SELECT Id, Language__c, Name, CorrectAnswer__c  From Question__c];

        List<QuestionResource__c> questionResources = [SELECT Id, Question__r.Language__c, Question__r.Name, Question__r.CorrectAnswer__c, (SELECT Name FROM Answers__r)  From QuestionResource__c WHERE Question__c IN ( SELECT Id FROM Question__c  )];
        Map<String, QuestionResource__c> questionMap = new Map<String, QuestionResource__c>(questionResources);


        return JSON.serializePretty(questionMap);

    }

}
