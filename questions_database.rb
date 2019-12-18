require 'sqlite3'
require 'singleton'
class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions1.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Question

    attr_accessor :id, :title, :body, :author_id
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question.first)
    end

end