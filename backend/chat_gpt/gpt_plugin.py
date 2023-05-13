import openai
import ast
import json

# openai 초기화
def init_openai():
    with open('chat_gpt/api_key.text', 'r', encoding='utf8') as f:
        api_key = f.read()
    openai.api_key = api_key
    model = "gpt-3.5-turbo"

    return model

# 메세지 초기화
def create_message( prompt ):
    return [
        {"role": "system", "content": prompt}
        ]

# 대화 user 메세지 append
def append_query_message(message, query):
    message.append({"role": "user", "content": query})

# 대화 assistant 메세지 append
def append_answer_message(message, answer):
    message.append({"role": "assistant", "content": answer})

# 대화 system 메세지 append
def append_system_message(message, answer):
    message.append({"role": "system", "content": answer})

# 처음 메세지 user, assistant 메세지 삭제
# 일정 토큰 이상일 때 동작
def del_message(messages, idx=2):
    del messages[idx]
    del messages[idx]

    return messages


# 페르소나 프롬프트
def create_personas_prompt( prompt, persona,nickname, name, species, age ):
    prompt = prompt.format( persona=persona, nickname=nickname, name=name,species=species,age=age )
    return prompt

def create_prompt( prompt, text ):
    prompt = prompt.format( text=text )
    return prompt


# 과거 진위 판별 함수
def make_distinguish_chat( model, messages ):
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0.5,
        max_tokens=30,
        top_p=1.0,
        frequency_penalty=0.5,
        presence_penalty=0.0,
        stop=[":"]
    )

    print(response['usage']['total_tokens'])
    answer = response['choices'][0]['message']['content']
    print(answer)
    if answer[0] == "{'" and answer[-1] == "}" :
        return ast.literal_eval(answer)
    return ['x']


# API 호출, 강아지와 대화
def create_chat_dog( model, messages ):
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages
    )
    return response

# 대화내용 요약 ( 현재 미사용 )
def create_chat_summary( model, messages ):
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages
    )
    return response['choices'][0]['message']['content']


def gpt( query ):

    messages_dog = list() 

    # 추후에 들어올 강아지 정보
    dog_info = {'persona':'우주비행사','nickname':'예찬','name':'뽀또', 'species':'말티즈','age':'3'}
    flag = True
    
    # prompt 저장소에서 prompt를 가져옴
    with open('chat_gpt/prompt_save.json','r', encoding='utf-8') as f:
        prompt_file = json.load(f)
        prompt = prompt_file["prompt"][0]["content"]
        dog_persona_prompt = prompt_file["prompt"][1]["content"]

    prompt_persona = create_personas_prompt( dog_persona_prompt, dog_info['persona'],dog_info['nickname'], dog_info['name'] , dog_info['species'], dog_info['age'] )
    model = init_openai()

    # 멍채팅
    if flag : 
        messages_dog = create_message( prompt_persona )
        flag=False

    messages = [{"role": "system", "content": create_prompt( prompt, query ) }]
    emotion = create_chat_summary( model, messages )
    print(emotion)
    
    append_query_message(messages_dog, query)

    rep = create_chat_dog(model, messages_dog)

    answer = rep['choices'][0]['message']['content']
    print(answer)

    append_answer_message(messages_dog, answer)
    print(rep['usage']['total_tokens'])
    if rep['usage']['total_tokens'] > 1000:
        messages_dog = del_message(messages=messages_dog, idx=1)

    return answer