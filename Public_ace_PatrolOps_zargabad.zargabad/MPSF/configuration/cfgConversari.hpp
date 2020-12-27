class nearbyEncounters {
    startPoints[] = {"npc_intro"};
    resumePoints[] = {"npc_reIntro"};
 // Responses
    class npc_intro {
        displayText = "Hi, who are you?";
        options[] = {"action_introduce","action_goodbye"};
    };
    class npc_reIntro {
        displayText = "Hi, %1.";
        options[] = {"action_reintroduce","action_goodbye"};
        arguments[] = {"name player"};
    };
    class npc_question_1 {
        displayText = "%1, What can I help you with?";
        options[] = {"action_askIntel_1","action_askIntel_4","action_askIntel_5","action_goodbye"};
        arguments[] = {"name player"};
    };
    class npc_question_2 {
        displayText = "%1, What do you want?";
        options[] = {"action_askIntel_2","action_askIntel_3","action_askIntel_5","action_goodbye"};
        arguments[] = {"name player"};
    };
    class npc_question_3 {
        displayText = "%1, I'm very busy, what do you want?";
        options[] = {"action_askIntel_4","action_askIntel_2","action_askIntel_5","action_goodbye"};
        arguments[] = {"name player"};
    };
    class npc_question_4 {
        displayText = "I'm too busy to assist you, Bye. (Scared)";
        endConversation = 1;
    };
    class npc_intel_1 {
        displayText = "%1";
        options[] = {"action_goodbye_thanks","action_goodbye"};
        arguments[] = {"(_this + [1]) call PO4_fnc_conversationResponses"};
        code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
        removeAction = 1;
    };
    class npc_intel_2 {
        displayText = "%1";
        options[] = {"action_goodbye_thanks","action_goodbye"};
        arguments[] = {"(_this + [2]) call PO4_fnc_conversationResponses"};
        code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
        removeAction = 1;
    };
    class npc_intel_3 {
        displayText = "%1";
        options[] = {"action_goodbye_thanks","action_goodbye"};
        arguments[] = {"(_this + [3]) call PO4_fnc_conversationResponses"};
        //code = "['onIntelRecieve',_this,0] call MPSF_fnc_triggerEventHandler;";
        removeAction = 1;
    };
    class npc_goodbye_1 {
        displayText = "Goodbye and good luck %1.";
        arguments[] = {"name player"};
        endConversation = 1;
    };
    class npc_goodbye_2 {
        displayText = "Good luck...";
        endConversation = 1;
    };
// Actions
    class action_introduce {
        displayText = "Introduce yourself";
        responses[] = {"npc_question_1","npc_question_2","npc_question_3"};
    };
    class action_reintroduce {
        displayText = "Exchange salutations";
        responses[] = {"npc_question_1","npc_question_2"};
    };
    class action_askIntel_1 {
        displayText = "Ask about any INTEL on enemy";
        responses[] = {"npc_intel_1","npc_intel_2","npc_intel_3"};
    };
    class action_askIntel_2 {
        displayText = "Ask if they have seen any hostile forces nearby";
        responses[] = {"npc_intel_2"};
    };
    class action_askIntel_3 {
        displayText = "Ask if they have seen anything recently";
        responses[] = {"npc_intel_2","npc_intel_3"};
    };
    class action_askIntel_4 {
        displayText = "Ask if everything is ok";
        responses[] = {"npc_question_4"};
    };
    class action_askIntel_5 {
        displayText = "Ask if they could point you to the nearest toilet";
        responses[] = {"npc_question_4"};
    };
    class action_goodbye_thanks {
        displayText = "Thank them and farewell";
        responses[] = {"npc_goodbye_1"};
    };
    class action_goodbye {
        displayText = "Say Goodbye";
        responses[] = {"npc_goodbye_1","npc_goodbye_2"};
    };
};