defmodule CustomerFeedback.SettingsTest do
  use CustomerFeedback.DataCase

  alias CustomerFeedback.Settings

  describe "questions" do
    alias CustomerFeedback.Settings.Question

    @valid_attrs %{question: "some question"}
    @update_attrs %{question: "some updated question"}
    @invalid_attrs %{question: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Settings.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Settings.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Settings.create_question(@valid_attrs)
      assert question.question == "some question"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Settings.update_question(question, @update_attrs)
      assert question.question == "some updated question"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_question(question, @invalid_attrs)
      assert question == Settings.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Settings.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Settings.change_question(question)
    end
  end
end
