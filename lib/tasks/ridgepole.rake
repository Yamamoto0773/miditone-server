namespace :ridgepole do
  task apply: :environment do
    run_ridgepole('--apply')
    Rake::Task['db:schema:dump'].invoke
  end

  def run_ridgepole(arg)
    command = 'ridgepole -o db/schema.rb -c config/database.yml -f db/Schemafile --dump-with-default-fk-name '
    command += arg
    system command
  end
end
