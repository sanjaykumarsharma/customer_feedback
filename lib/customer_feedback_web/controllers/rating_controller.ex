defmodule CustomerFeedbackWeb.RatingController do
  use CustomerFeedbackWeb, :controller

  alias CustomerFeedback.Ratings
  alias CustomerFeedback.Ratings.Rating
  alias CustomerFeedback.Accounts

  alias CustomerFeedback.Customers.Customer

  def index(conn, _params) do
    ratings = Ratings.list_ratings()
    render(conn, "index.html", ratings: ratings)
  end

  def new(conn, %{"id" => id, "mobile" => mobile}) do
    changeset = Ratings.change_rating(%Rating{})
    render(conn, "new.html", changeset: changeset, id: id, mobile: mobile)
  end

  def create(conn, %{"id" => id, "mobile" => mobile, "rating" => rating_params}) do
    case Ratings.create_rating(rating_params, mobile, conn.assigns.current_user.id) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating created successfully.")
        |> redirect(to: Routes.rating_path(conn, :mobile_form))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, id: id, mobile: mobile)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   rating = Ratings.get_rating!(id)
  #   render(conn, "show.html", rating: rating)
  # end

  # def edit(conn, %{"id" => id}) do
  #   rating = Ratings.get_rating!(id)
  #   changeset = Ratings.change_rating(rating)
  #   render(conn, "edit.html", rating: rating, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "rating" => rating_params}) do
  #   rating = Ratings.get_rating!(id)

  #   case Ratings.update_rating(rating, rating_params) do
  #     {:ok, rating} ->
  #       conn
  #       |> put_flash(:info, "Rating updated successfully.")
  #       |> redirect(to: Routes.rating_path(conn, :show, rating))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", rating: rating, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   rating = Ratings.get_rating!(id)
  #   {:ok, _rating} = Ratings.delete_rating(rating)

  #   conn
  #   |> put_flash(:info, "Rating deleted successfully.")
  #   |> redirect(to: Routes.rating_path(conn, :index))
  # end

  # Customer data 
  def mobile_form(conn, _params) do
    render(conn, "mobile.html")
  end

  def check_mobile(conn, %{"mobile" => mobile}) do
    case String.length(mobile) do
      10 ->
        case Accounts.get_customer_by_mobile(conn.assigns.current_user.id, mobile) do
          nil ->
            changeset = Ratings.change_customer(%Customer{})

            conn
            |> render("new_customer.html", changeset: changeset, mobile: mobile)

          {:ok, record} ->
            changeset = Ratings.change_customer(record)

            conn
            |> render("edit_customer.html",
              id: record.id,
              mobile: record.mobile,
              changeset: changeset
            )
        end

      _ ->
        conn
        |> render("mobile.html")
    end
  end

  def create_customer(conn, %{"customer" => customer_params}) do
    case Ratings.create_customer(customer_params, conn.assigns.current_user.id) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer created successfully.")
        |> redirect(to: Routes.rating_path(conn, :new, customer.id, customer.mobile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_customer.html",
          changeset: changeset,
          mobile: customer_params["mobile"]
        )
    end
  end

  def update_customer(conn, %{"id" => id, "customer" => customer_params}) do
    IO.inspect(customer_params)
    customer = Accounts.get_customer!(id)
    IO.inspect(customer)
    conn

    case Accounts.update_customer(customer, customer_params) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Customer updated successfully.")
        |> redirect(to: Routes.rating_path(conn, :new, id, customer.mobile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_customer.html", id: id, mobile: customer.mobile, changeset: changeset)
    end
  end
end
