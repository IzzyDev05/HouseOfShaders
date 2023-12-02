using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 8f;

    private float horizontal;
    private float vertical;
    private Vector3 moveDirection;
    private Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        horizontal = Input.GetAxisRaw("Horizontal");
        vertical = Input.GetAxisRaw("Vertical");

        Vector3 flatVelocity = new Vector3(rb.velocity.x, 0f, rb.velocity.z);
        if (flatVelocity.magnitude > moveSpeed)
        {
            Vector3 newVelocity = flatVelocity.normalized * moveSpeed;
            rb.velocity = new Vector3(newVelocity.x, rb.velocity.y, newVelocity.z);
        }
    }

    private void FixedUpdate()
    {
        moveDirection = transform.forward * vertical + transform.right * horizontal;
        rb.AddForce(moveDirection.normalized * moveSpeed, ForceMode.Impulse);
    }
}