Dado("exista a seguinte reserva cadastrada no sistema:")do |table|
	table.rows_hash.each do |field, value|
	    @appointment = Appointment.new
	    @appointment.appointment_date = Date.today + 1
	    @appointment.start_time = value
	    @appointment.user_id = User.last.id
	    @appointment.room_id = Room.where(name: value, location:value).ids
	    @appointment.save
  end

end

Quando ("não for preenchido o campo de data") do
    fill_in :with => ''
end

Quando("preencher o dia da reserva com:") do |table|
	table.rows_hash.each do |field, value|
		fill_in field, :with => Date.today + 1
	end
end

Então ("devo estar uma página com a tabela com as salas não reservadas") do
	expect(page).to have_css 'table'
end

Quando("selecionar o seguinte horário de {string} da manhã para buscar") do |string|
  select string, from: "time_search"
end