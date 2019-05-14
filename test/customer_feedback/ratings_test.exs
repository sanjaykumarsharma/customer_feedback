defmodule CustomerFeedback.RatingsTest do
  use CustomerFeedback.DataCase

  alias CustomerFeedback.Ratings

  describe "ratings" do
    alias CustomerFeedback.Ratings.Rating

    @valid_attrs %{mobile: "some mobile", rating: 42, rating_date: ~D[2010-04-17]}
    @update_attrs %{mobile: "some updated mobile", rating: 43, rating_date: ~D[2011-05-18]}
    @invalid_attrs %{mobile: nil, rating: nil, rating_date: nil}

    def rating_fixture(attrs \\ %{}) do
      {:ok, rating} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ratings.create_rating()

      rating
    end

    test "list_ratings/0 returns all ratings" do
      rating = rating_fixture()
      assert Ratings.list_ratings() == [rating]
    end

    test "get_rating!/1 returns the rating with given id" do
      rating = rating_fixture()
      assert Ratings.get_rating!(rating.id) == rating
    end

    test "create_rating/1 with valid data creates a rating" do
      assert {:ok, %Rating{} = rating} = Ratings.create_rating(@valid_attrs)
      assert rating.mobile == "some mobile"
      assert rating.rating == 42
      assert rating.rating_date == ~D[2010-04-17]
    end

    test "create_rating/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ratings.create_rating(@invalid_attrs)
    end

    test "update_rating/2 with valid data updates the rating" do
      rating = rating_fixture()
      assert {:ok, %Rating{} = rating} = Ratings.update_rating(rating, @update_attrs)
      assert rating.mobile == "some updated mobile"
      assert rating.rating == 43
      assert rating.rating_date == ~D[2011-05-18]
    end

    test "update_rating/2 with invalid data returns error changeset" do
      rating = rating_fixture()
      assert {:error, %Ecto.Changeset{}} = Ratings.update_rating(rating, @invalid_attrs)
      assert rating == Ratings.get_rating!(rating.id)
    end

    test "delete_rating/1 deletes the rating" do
      rating = rating_fixture()
      assert {:ok, %Rating{}} = Ratings.delete_rating(rating)
      assert_raise Ecto.NoResultsError, fn -> Ratings.get_rating!(rating.id) end
    end

    test "change_rating/1 returns a rating changeset" do
      rating = rating_fixture()
      assert %Ecto.Changeset{} = Ratings.change_rating(rating)
    end
  end
end
