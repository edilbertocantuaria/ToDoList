Task.destroy_all
TaskList.destroy_all
Tag.destroy_all
User.destroy_all

user1 = User.create!(
  name: "João",
  email: "joao@example.com",
  password: "password123",
  password_confirmation: "password123",
  user_picture: "https://this-person-does-not-exist.com/img/avatar-gen851f9c29e5f6857320e36f7359c01c5b.jpg"
)

user2 = User.create!(
  name: "Maria",
  email: "maria@example.com",
  password: "password456",
  password_confirmation: "password456",
  user_picture: "https://this-person-does-not-exist.com/img/avatar-gen4e1a0a1daffae1239fe54c59b1003ba4.jpg"
)

tag1 = Tag.create!(tag_name: "Trabalho", user: user1)
tag2 = Tag.create!(tag_name: "Pessoal", user: user2)
tag3 = Tag.create!(tag_name: "Estudo", user: user1)

task_lists_user1 = [
  {
    title: "Lista de Trabalho",
    attachment: "https://conasems-ava-prod.s3.sa-east-1.amazonaws.com/aulas/ava/dummy-1641923583.pdf",
    percentage: 0.75,
    tag: tag1,
    tasks: [
      { description: "Concluir o relatorio semanal", is_done: false },
      { description: "Preparar a reuniao de segunda-feira", is_done: true }
    ]
  },
  {
    title: "Lista de Estudos",
    attachment: nil,
    percentage: 0.5,
    tag: tag3,
    tasks: [
      { description: "Estudar Ruby on Rails", is_done: false },
      { description: "Revisar o projeto final", is_done: true }
    ]
  },
  {
    title: "Lista de Compras",
    attachment: nil,
    percentage: 0.25,
    tag: nil,
    tasks: [
      { description: "Comprar frutas e vegetais", is_done: false },
      { description: "Comprar cafe e pao", is_done: true }
    ]
  }
]

task_lists_user1.each do |task_list_data|
  task_list = TaskList.create!(
    title: task_list_data[:title],
    user: user1,
    attachment: task_list_data[:attachment],
    tag: task_list_data[:tag]
  )

  task_list_data[:tasks].each do |task_data|
    Task.create!(
      task_list: task_list,
      task_description: task_data[:description],
      is_task_done: task_data[:is_done]
    )
  end
end

task_lists_user2 = [
  {
    title: "Lista de Tarefas Pessoais",
    attachment: "https://conasems-ava-prod.s3.sa-east-1.amazonaws.com/aulas/ava/dummy-1641923583.pdf",
    percentage: 0.6,
    tag: tag2,
    tasks: [
      { description: "Comprar presentes de Natal", is_done: false },
      { description: "Agendar consulta medica", is_done: true }
    ]
  }
]

task_lists_user2.each do |task_list_data|
  task_list = TaskList.create!(
    title: task_list_data[:title],
    user: user2,
    attachment: task_list_data[:attachment],
    tag: task_list_data[:tag]
  )

  task_list_data[:tasks].each do |task_data|
    Task.create!(
      task_list: task_list,
      task_description: task_data[:description],
      is_task_done: task_data[:is_done]
    )
  end
end

puts "Seed concluído com sucesso!"
